local attach = require "lsp.attach"
local capabilities = require "lsp.capabilities"

require("lsp.null-ls").setup()

require("rust-tools").setup {
  server = {
    on_attach = attach.on_attach,
    capabilities = capabilities,
  },
}
