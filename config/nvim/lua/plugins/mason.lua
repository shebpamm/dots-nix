local m = require "mason"
local md = require "mason-nvim-dap"

m.setup {
  PATH = "append",
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

md.setup {
  automatic_setup = true,
}
