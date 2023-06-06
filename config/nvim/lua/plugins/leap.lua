return {
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require "leap"

      leap.add_default_mappings()
    end,
  },

  {
    "ggandor/leap-spooky.nvim",
    config = function()
      require("leap-spooky").setup()
    end,
  },
}
