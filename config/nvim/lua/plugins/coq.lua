return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  commit = "e7304683400a65e3f85e6973fcc2ad2a1bc811e6",
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
  end,
}
