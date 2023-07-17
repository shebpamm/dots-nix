return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  -- commit = "5eddd31bf8a98d1b893b0101047d0bb31ed20c49",
  dependencies = {
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  build = ":COQdeps",
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
      clients = {
        tree_sitter = { enabled = false },
        paths = { enabled = true, resolution = { "file" } },
        snippets = { enabled = true, warn = {} },
        tags = { enabled = false },
        tmux = { enabled = false },
      },
      keymap = { recommended = true },
      display = {
        preview = { positions = { north = 4, south = nil, west = 2, east = 3 } },
      },
    }
    require "coq_3p" {
      { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
    }
  end,
}
