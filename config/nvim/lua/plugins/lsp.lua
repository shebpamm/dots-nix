return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  },

  "ray-x/go.nvim",
  "stevearc/conform.nvim",
}
