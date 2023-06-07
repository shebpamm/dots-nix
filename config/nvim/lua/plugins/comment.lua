return {
  "numToStr/Comment.nvim",
  keys = {
    "gc",
    "gb",
    "gcc",
    "gbc",
    "gbc",
    { "gc", mode = "v" },
    { "gb", mode = "v" }
  },
  config = function()
    require("Comment").setup {
      padding = true,
      sticky = true,
      mappings = {
        basic = true,
        extra = true,
      },
    }
  end,
}
