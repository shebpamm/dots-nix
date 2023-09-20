-- This function finds the path to the user's configuration directory
local function find_config_path()
  local config = vim.fn.expand "$XDG_CONFIG_HOME" -- Check if XDG_CONFIG_HOME environment variable is set
  if config and vim.fn.isdirectory(config) > 0 then -- If it is set and is a directory, return it
    return config
  elseif vim.fn.has "win32" > 0 then -- If on Windows
    config = vim.fn.expand "~/AppData/Local" -- Set config path to default Windows config path
    if vim.fn.isdirectory(config) > 0 then -- If it exists, return it
      return config
    end
  else -- If on Unix-like system
    config = vim.fn.expand "~/.config" -- Set config path to default Unix-like config path
    if vim.fn.isdirectory(config) > 0 then -- If it exists, return it
      return config
    else -- If it doesn't exist, print an error message
      print "Error: could not find config path"
    end
  end
end

local function get_copilot_token()
  local userdata =
    vim.json.decode(vim.api.nvim_eval("readfile('" .. find_config_path() .. "/github-copilot/hosts.json')")[1])
  local token = userdata["github.com"].oauth_token
  return token
end

-- Define a function to get the bearer token
local function get_bearer()
  local copilot_token = get_copilot_token()
  local headers = {
    authorization = "token " .. copilot_token,
    editor_version = " vscode/1.79.0-insider",
    editor_plugin_version = " copilot/1.86.112",
    user_agent = " GithubCopilot/1.86.112",
    accept = " */*",
  }

  local curl = require "plenary.curl"

  local response = curl.get {
    url = "https://api.github.com/copilot_internal/v2/token",
    headers = headers,
    accept = "application/json",
  }

  local token = vim.fn.json_decode(response.body)["token"]
  -- print(token)

  return token
end

local model = { model = "copilot-chat", temperature = 0.1, top_p = 1 }

return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup {
      openai_api_endpoint = "https://copilot-proxy.githubusercontent.com/v1/chat/completions",
      openai_api_key = get_bearer(),
      chat_model = model,
      chat_topic_gen_model = model,
      command_model = model,
    }
  end,
  cmd = {
    "GpChatNew",
    "GpRewrite",
    "GpAppend",
    "GpPrepend",
    "GpEnew",
    "GpPopup",
  },
}
