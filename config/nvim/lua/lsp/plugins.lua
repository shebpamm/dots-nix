require "lsp.mappings"

require("lsp.format").setup()

require("go").setup {
  lsp_cfg = true,
}
