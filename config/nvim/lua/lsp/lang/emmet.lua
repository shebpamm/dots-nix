local M = {}

M.setup = {
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
    cmd = { "npx", "emmet-ls", "--stdio" },
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
    settings = {},
}

return M
