local s = require "session_manager"
local sc = require "session_manager.config"
local wk = require "which-key"

s.setup {
  autoload_mode = sc.AutoloadMode.Disabled
}

wk.register {
  ["<leader>"] = {
    -- find
    s = {
      name = "+session",
      f = { "<cmd>SessionManager load_session<cr>", "Load Session" },
      l = { "<cmd>SessionManager load_last_session<cr>", "Last Session" },
      c = { "<cmd>SessionManager load_current_dir_session<cr>", "Current Directory Session" },
      s = { "<cmd>SessionManager save_current_session<cr>", "Save Session" },
      d = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
    },
  },
}
