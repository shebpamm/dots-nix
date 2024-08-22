return {
  {
    "chentoast/marks.nvim",
    lazy = false,
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "^", "<", ">" },
      cyclic = true,
    },
    keys = {
      { "<leader>mt", "<cmd>MarksToggleSigns<cr>", desc = "toggle signs" },
      { "<leader>ml", "<cmd>MarksQFListAll<cr>", desc = "list all marks" },
      { "<leader>mb", "<cmd>BookmarksQFListAll<cr>", desc = "list all bookmarks" },
    },
  },
}
