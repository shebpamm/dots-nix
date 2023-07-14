return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    module = "gitsigns",
    keys = {
      { "<leader>vs",	function() require"gitsigns".stage_hunk() end,	                                        mode = "n" },
      { "<leader>vs",	function() require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end,      mode = "v" },
      { "<leader>vu",	function() require"gitsigns".undo_stage_hunk() end,	                                mode = "n" },
      { "<leader>vr",	function() require"gitsigns".reset_hunk() end,	                                        mode = "n" },
      { "<leader>vr",	function() require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end,	mode = "v" },
      { "<leader>vR",	function() require"gitsigns".reset_buffer() end,	                                mode = "n" },
      { "<leader>vp",	function() require"gitsigns".preview_hunk() end,	                                mode = "n" },
      { "<leader>vb",	function() require"gitsigns".toggle_current_line_blame() end,	                        mode = "n" },

    },
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
      }
    end,
  },
  "tpope/vim-fugitive",
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = "neogit",
  },
}
