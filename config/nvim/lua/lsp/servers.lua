local servers = {
  lua_ls = require("lsp.lang.lua").setup,
  pyright = require("lsp.lang.python").setup,
  ts_ls = require("lsp.lang.typescript").setup,
  ansiblels = require("lsp.lang.ansible").setup,

  awk_ls = nil,
  bashls = nil,
  clangd = nil,
  cssls = nil,
  dockerls = nil,
  dotls = nil,
  hls = nil,
  html = nil,
  jsonls = nil,
  nil_ls = nil,
  robotframework_ls = nil,
  ruff = nil,
  sqlls = nil,
  taplo = nil,
  tflint = nil,
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    if opts ~= nil then
      vim.lsp.config(name, opts)
    end
    vim.lsp.enable(name)
  end
end
