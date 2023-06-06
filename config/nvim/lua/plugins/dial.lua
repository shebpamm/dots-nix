return {
  "monaqa/dial.nvim",
  keys = { "<C-a>", "<C-x>" },
  config = function()
    local wk = require "which-key"
    local dm = require "dial.map"
    local dc = require "dial.config"
    local da = require "dial.augend"

    wk.register {
      ["<C-a>"] = { dm.inc_normal(), "increment" },
      ["<C-x>"] = { dm.dec_normal(), "decrement" },
    }

    wk.register({
      ["<C-a>"] = dm.inc_visual(),
      ["<C-x>"] = dm.dec_visual(),
      ["g<C-a>"] = dm.inc_gvisual(),
      ["g<C-x>"] = dm.dec_gvisual(),
    }, {
      mode = "v",
    })

    dc.augends:register_group {
      -- default augends used when no group name is specified
      default = {
        da.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        da.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        da.integer.alias.binary,
        da.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        da.constant.alias.bool,
        da.semver.alias.semver,
      },
    }
  end,
}
