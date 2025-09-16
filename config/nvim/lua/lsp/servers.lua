local servers = {
  emmet_ls = require("lsp.lang.emmet").setup,
  lua_ls = require("lsp.lang.lua").setup,
  pyright = require("lsp.lang.python").setup,
  ts_ls = require("lsp.lang.typescript").setup,
  ansiblels = require("lsp.lang.ansible").setup,

  awk_ls = {},
  bashls = {},
  clangd = {},
  cssls = {},
  dockerls = {},
  dotls = {},
  hls = {},
  html = {},
  jsonls = {},
  nil_ls = {},
  robotframework_ls = {},
  ruff = {},
  sqlls = {},
  taplo = {},
  tflint = {},
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
  end
end
