local attach = require "lsp.attach"
local capabilities = require "lsp.capabilities"

require "lsp.mappings"

require("lsp.null-ls").setup()

require("rust-tools").setup {
  server = {
    on_attach = attach.on_attach,
    capabilities = capabilities,
  },
}

require("go").setup {
  lsp_cfg = true
}
