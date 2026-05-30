local aws_profile = "bedrock_playground"
local cached_creds = nil

local function credentials_expired(creds)
  if not creds or not creds.expiration then
    return true
  end

  -- Expire 5 minutes early to avoid edge races.
  local expires_at = vim.fn.strptime("%Y-%m-%dT%H:%M:%SZ", creds.expiration)
  local now = os.time()

  return now >= (expires_at - 300)
end

local function fetch_granted_credentials()
  local result = vim
    .system({
      "granted",
      "credential-process",
      "--auto-login",
      "--profile",
      aws_profile,
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    vim.notify(("granted credential-process failed:\n%s"):format(result.stderr or ""), vim.log.levels.ERROR)
    return nil
  end

  local ok, data = pcall(vim.json.decode, result.stdout or "")
  if not ok then
    vim.notify("Failed to decode Granted credential JSON", vim.log.levels.ERROR)
    return nil
  end

  return {
    access_key = data.AccessKeyId,
    secret_key = data.SecretAccessKey,
    session_token = data.SessionToken,
    expiration = data.Expiration,
    source = "granted",
  }
end

local function get_aws_credentials()
  if cached_creds and not credentials_expired(cached_creds) then
    return cached_creds
  end

  -- Prefer env vars if available.
  local access_key = os.getenv "AWS_ACCESS_KEY_ID"
  local secret_key = os.getenv "AWS_SECRET_ACCESS_KEY"
  local session_token = os.getenv "AWS_SESSION_TOKEN"

  if access_key and secret_key and session_token then
    cached_creds = {
      access_key = access_key,
      secret_key = secret_key,
      session_token = session_token,
      expiration = os.getenv "AWS_CREDENTIAL_EXPIRATION",
      source = "env",
    }

    return cached_creds
  end

  -- Fetch fresh credentials from Granted.
  cached_creds = fetch_granted_credentials()
  return cached_creds
end

local aws_curl = function()
  if require("minuet").config.provider ~= "claude" then
    return {}
  end

  local creds = get_aws_credentials()
  if not creds then
    return {}
  end

  local user = creds.access_key .. ":" .. creds.secret_key

  return {
    "-H",
    "X-Amz-Security-Token: " .. creds.session_token,
    "--aws-sigv4",
    "aws:amz:us-east-1:bedrock-mantle",
    "--user",
    user,
    "-X",
    "POST",
  }
end

local setup_minuet = function()
  local provider = os.getenv "NVIM_LLM_PROVIDER" or "claude"

  local opts = {
    provider = provider,
    request_timeout = 5,
    curl_extra_args = aws_curl,

    provider_options = {
      claude = {
        end_point = "https://bedrock-mantle.us-east-1.api.aws/anthropic/v1/messages",
        model = "anthropic.claude-haiku-4-5",
        api_key = function()
          return "none"
        end,
        stream = true,
        transform = {
          function(opts)
            opts.headers["x-api-key"] = nil
            return opts
          end,
        },
      },
      provider_options = {
        openai_fim_compatible = {
          api_key = "DEEPSEEK_API_KEY",
          name = "deepseek",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    },
    virtualtext = {
      auto_trigger_ft = {
        "lua",
        "rust",
        "nix",
        "python",
        "javascript",
        "typescript",
        "yaml",
      },
      keymap = {
        accept = "<C-f>",
        accept_line = "<C-e>",
      },
    },
  }

  require("minuet").setup(opts)
end

return {
  "milanglacier/minuet-ai.nvim",
  config = setup_minuet,
}
