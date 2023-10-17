return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  },

  "simrat39/rust-tools.nvim",
  "ray-x/go.nvim",
  "nvimtools/none-ls.nvim",
}
