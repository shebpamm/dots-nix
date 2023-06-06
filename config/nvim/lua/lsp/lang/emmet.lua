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
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
    settings = {},
}

return M
