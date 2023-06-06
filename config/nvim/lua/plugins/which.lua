return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      plugins = {
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        },
      },
    }
  end,
}
