local lspconfig = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local configs = require "lspconfig/configs"
configs.emmet_ls = {
  default_config = {
    cmd = { "npx emmet_ls", "--stdio" },
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "haml",
      "xml",
      "xsl",
      "pug",
      "slim",
      "sass",
      "stylus",
      "less",
      "sss",
    },
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
    settings = {},
  },
}
