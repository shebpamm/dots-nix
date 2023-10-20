return {
  "luckasRanarison/clear-action.nvim",
  opts = {
    signs = {
      show_label = true,
      position = "right_align",
    },
  },
  quickfix_filters = {
    ["lua_ls"] = {
      ["unused-local"] = "Disable diagnostics on this line",
      ["lowercase-global"] = "Disable diagnostics",
    },
  },
}
