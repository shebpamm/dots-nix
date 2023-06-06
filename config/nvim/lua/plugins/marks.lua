return {
  "chentoast/marks.nvim",
  config = function()
    local marks = require "marks"
    local wk = require "which-key"

    marks.setup {
      default_mappings = true,
      builtin_marks = { ".", "^", "<", ">" },
      cyclic = true,
    }

    wk.register {
      ["<leader>"] = {
        -- find
        m = {
          name = "+marks",
          t = { "<cmd>MarksToggleSigns<cr>", "toggle signs" },
          l = { "<cmd>MarksQFListAll<cr>", "list all marks" },
          b = { "<cmd>BookmarksQFListAll<cr>", "list all bookmarks" },
        },
      },
    }
  end,
}
