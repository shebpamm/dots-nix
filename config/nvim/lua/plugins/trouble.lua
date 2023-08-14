return {
  "folke/trouble.nvim",
  keys = {
    {
      "gr",
      function()
        require("trouble").open "lsp_references"
      end,
      desc = "references",
    },
  },
  cmd = { "Trouble", "TroubleToggle" },
  opts = {
    auto_close = true,
    auto_preview = true,
  },
}
