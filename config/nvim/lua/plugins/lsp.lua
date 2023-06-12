return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    config = function()
      require("lsp-inlayhints").setup()
    end,
  },

  "simrat39/rust-tools.nvim",
  "jose-elias-alvarez/null-ls.nvim",
}
