return {
  "gruvw/strudel.nvim",
  build = "npm ci",
  config = function()
    local strudel = require "strudel"

    strudel.setup {
      browser_exec_path = "/home/shebpamm/.nix-profile/bin/google-chrome-stable",
    }

  end,
  keys = {
    {
      "<leader>pl",
      function()
        require("strudel").launch()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>pq",
      function()
        require("strudel").quit()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>pt",
      function()
        require("strudel").toggle()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>pu",
      function()
        require("strudel").update()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>ps",
      function()
        require("strudel").stop()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>pb",
      function()
        require("strudel").set_buffer()
      end,
      { desc = "Launch Strudel" },
    },
    {
      "<leader>px",
      function()
        require("strudel").execute()
      end,
      { desc = "Launch Strudel" },
    },
  },
}
