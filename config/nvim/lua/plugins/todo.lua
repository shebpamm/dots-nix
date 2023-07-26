return {
  "folke/todo-comments.nvim",
  event = "BufRead",
  opts = {
    signs = false,
    colors = {
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#ea6962" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#d8a657" },
      info = { "LspDiagnosticsDefaultInformation", "#a9b665" },
      hint = { "LspDiagnosticsDefaultHint", "#89b482" },
      default = { "Identifier", "#7daea3" },
    },
  },
}
