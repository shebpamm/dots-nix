return {
  {
    "plasticboy/vim-markdown",
    dependencies = {
      "godlygeek/tabular",
      opt = true,
    },
    ft = "markdown",
  },
  {
    "kiran94/edit-markdown-table.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "EditMarkdownTable",
  },
}
