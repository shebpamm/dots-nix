local lspconfig = require "lspconfig"
local coq = require "coq"

local capabilities = require "lsp.capabilities"
local attach = require "lsp.attach"

local servers = {
  emmet_ls = require("lsp.lang.emmet").setup,
  lua_ls = require("lsp.lang.lua").setup,
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
  -- gopls = {},
  nil_ls = {},
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = lspconfig[name]
    client.setup(coq.lsp_ensure_capabilities(vim.tbl_extend("force", {
      flags = { debounce_text_changes = 150 },
      on_attach = attach.on_attach,
      capabilities = capabilities,
    }, opts)))
  end
end
