return {
  "folke/trouble.nvim",
  cmd = { "Trouble", "TroubleToggle" },
  config = function()
    require("trouble").setup {
      auto_close = true,
    }
  end,
}
