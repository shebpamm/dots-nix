return {
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require "leap"

      -- leap.add_default_mappings()
    end,
  },

  {
    "shebpamm/leap-spooky.nvim",
    config = function()
      require("leap-spooky").setup {
        extra_text_objects = {
          "iq", "aq",
          "iv", "av",
          "ik", "ak",
        },
      }
    end,
  },
}
