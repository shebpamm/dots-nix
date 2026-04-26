vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    require("lsp.attach.autocommands").setup(client)
    require("lsp.attach.commands").setup()
    require "lsp.attach.handlers"
    require "lsp.attach.signs"
    require("lsp.attach.signature").on_attach(client, bufnr)
  end,
})
