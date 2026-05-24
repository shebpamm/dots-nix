local M = {}

local conform = require "conform"

M.setup = function()
  conform.setup {
    formatters_by_ft = {
      ["*"] = { "treefmt" },
    },
    formatters = {
      treefmt = {
        require_cwd = false,
      },
    },
  }
end

return M
