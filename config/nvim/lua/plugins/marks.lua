return {
  {
    "chentoast/marks.nvim",
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "^", "<", ">" },
      cyclic = true,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      ["<leader>"] = {
        -- find
        m = {
          name = "+marks",
          t = { "<cmd>MarksToggleSigns<cr>", "toggle signs" },
          l = { "<cmd>MarksQFListAll<cr>", "list all marks" },
          b = { "<cmd>BookmarksQFListAll<cr>", "list all bookmarks" },
        },
      },
    },
  },
}
