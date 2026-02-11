local servers = {
  lua_ls = require("lsp.lang.lua").setup,
  pyright = require("lsp.lang.python").setup,
  ts_ls = require("lsp.lang.typescript").setup,
  yamlls = require("lsp.lang.yaml").setup,

  awk_ls = true,
  bashls = true,
  clangd = true,
  cssls = true,
  dockerls = true,
  dotls = true,
  hls = true,
  html = true,
  jsonls = true,
  true_ls = nil,
  robotframework_ls = true,
  ruff = true,
  sqlls = true,
  taplo = true,
  tflint = true,
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    if type(opts) == "table" then
      vim.lsp.config(name, opts)
    end
    vim.lsp.enable(name)
  end
end
