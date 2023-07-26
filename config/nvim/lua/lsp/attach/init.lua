local M = {}


M.on_attach = function(client, bufnr)
  require("lsp.attach.autocommands").setup(client)
  require("lsp.attach.commands").setup()
  require("lsp.attach.mappings").setup(bufnr)
  require "lsp.attach.handlers"
  require "lsp.attach.signs"
end

return M
