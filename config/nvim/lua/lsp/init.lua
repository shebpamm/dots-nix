local lspconfig = require "lspconfig"
local ih = require "lsp-inlayhints"
local ml = require "mason-lspconfig"
local coq = require "coq"

vim.lsp.set_log_level "INFO"

ml.setup { automatic_installation = true }

local capabilities = require "lsp.capabilities"

local emmet_config = require "lsp.emmet"

local function on_attach(client, bufnr)
  require("lsp.autocommands").setup(client)
  require("lsp.commands").setup()
  require("lsp.mappings").setup(bufnr)
  require "lsp.handlers"
  require "lsp.signs"

  ih.on_attach(client, bufnr)
end

local servers = {
  emmet_ls = emmet_config,

  sumneko_lua = require("lsp.lang.lua").setup,
  pyright = require("lsp.lang.python").setup,
  tsserver = require("lsp.lang.typescript").setup,
  ansiblels = require("lsp.lang.ansible").setup,

  awk_ls = {},
  cssls = {},
  dockerls = {},
  dotls = {},
  html = {},
  jsonls = {},
  robotframework_ls = {},
  sqlls = {},
  taplo = {},
  terraformls = {},
  tflint = {},

  nil_ls = {
    settings = {
      ["nil"] = {
        formatting = { command = { "nixpkgs-fmt" } },
      },
    },
  },
}

require("lsp.null-ls").setup()

require("rust-tools").setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = lspconfig[name]
    client.setup(coq.lsp_ensure_capabilities(vim.tbl_extend("force", {
      flags = { debounce_text_changes = 150 },
      on_attach = on_attach,
      capabilities = capabilities,
    }, opts)))
  end
end
