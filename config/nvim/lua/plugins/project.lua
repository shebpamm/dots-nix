return {
  "ahmedkhalf/project.nvim",
  keys = { "<leader>fp" },
  cmd = { "ProjectRoot" },
  event = "VimEnter",
  config = function()
    require("project_nvim").setup {
      manual_mode = false,
      ignore_lsp = { "null-ls" },
      show_hidden = true,
      detection_methods = { "lsp", "pattern" },
      patterns = {
        "stylua.toml",
        "rc.lua",
        "config.org",
        "Makefile",
        "package.json",
        "Cargo.toml",
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "index.html",
        "!^.config",
      },
    }
  end,
}
