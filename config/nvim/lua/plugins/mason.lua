local m = require "mason"
local ml = require "mason-lspconfig"
local mn = require "mason-null-ls"

m.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

mn.setup {
  automatic_installation = true,
}
