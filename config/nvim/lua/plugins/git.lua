return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    module = "gitsigns",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,

          ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
          },
          ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
          },

          ["n <leader>vs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ["v <leader>vs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ["n <leader>vu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ["n <leader>vr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ["v <leader>vr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ["n <leader>vR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ["n <leader>vp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ["n <leader>vb"] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

          -- Text objects
          ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
      }
    end,
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = "neogit",
  },
}
