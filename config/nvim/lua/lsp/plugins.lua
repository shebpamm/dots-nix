require "lsp.mappings"

require("lsp.null-ls").setup()

require("go").setup {
  lsp_cfg = true
}
