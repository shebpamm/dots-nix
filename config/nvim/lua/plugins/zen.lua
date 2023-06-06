return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    config = function()
      require("zen-mode").setup {
        twilight = { enabled = false },
        gitsigns = { enabled = true },
        kitty = { enabled = true, font = "+4" },
      }
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
  },
}
