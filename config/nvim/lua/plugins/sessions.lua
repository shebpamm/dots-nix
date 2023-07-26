return {
  "shebpamm/neovim-session-manager", 
  event = "VimEnter",
  config = function()
    local s = require "session_manager"
    local sc = require "session_manager.config"

    s.setup {
      autoload_mode = sc.AutoloadMode.Disabled,
      autosave_extra_predicate = function()
        return #vim.fn.getbufinfo { buflisted = 1 } > 1
      end,
    }
  end,
  keys = {
    { "<leader>sf", "<cmd>SessionManager load_session<cr>", desc = "Load Session" },
    { "<leader>sl", "<cmd>SessionManager load_last_session<cr>", desc = "Last Session" },
    { "<leader>sc", "<cmd>SessionManager load_current_dir_session<cr>", desc = "Current Directory Session" },
    { "<leader>ss", "<cmd>SessionManager save_current_session<cr>", desc = "Save Session" },
    { "<leader>sd", "<cmd>SessionManager delete_session<cr>", desc = "Delete Session" },
  },
}
