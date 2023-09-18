return {
  "mfussenegger/nvim-treehopper",
  keys = {
    { "s", function() require("tsht").nodes() end, mode = "o" },
    { "s", function() require("tsht").nodes() end, mode = "n" }
  }
}
