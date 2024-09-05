local M = {}


M.on_attach = function(client, bufnr)
  require("lsp.attach.autocommands").setup(client)
  require("lsp.attach.commands").setup()
  require "lsp.attach.handlers"
  require "lsp.attach.signs"
  require "lsp.attach.signature".on_attach(client, bufnr)
end

return M
