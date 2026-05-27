return {
  "nvim-mini/mini.comment",
  keys = {
    "gc",
    "gcc",
    { "gc", mode = "v" },
    { "gb", mode = "v" },
  },
  opts = {
    mappings = {
      comment = "gc",
      comment_line = "gcc",
      comment_visual = "gc",
      textobject = "gc",
    },
  },
}
