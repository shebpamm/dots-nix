return {
  "andythigpen/nvim-coverage",
  requires = {
    "nvim-lua/plenary.nvim",
  },
  rocks = {
    { "lua-xmlreader" }
  },
  config = function()
    require("coverage").setup()
  end,
}
