return {
  "folke/trouble.nvim",
  keys = {
    {
      "gr",
      function()
        require("trouble").toggle "lsp_references"
        require("trouble").focus()
      end,
      desc = "references",
    },
    {
      "<leader>d",
      function()
        require("trouble").toggle "diagnostics"
        require("trouble").focus()
      end,
      desc = "references",
    },
  },
  cmd = { "Trouble" },
  opts = {
    auto_close = true,
    auto_preview = true,
  },
}
