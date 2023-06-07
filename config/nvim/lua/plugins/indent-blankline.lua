return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  config = function()
    require("indent_blankline").setup {
      char = "|",
      context_char = "|",
      show_foldtext = false,
      show_first_indent_level = true,
      filetype_exclude = {
        "dashboard",
        "log",
        "gitcommit",
        "packer",
        "markdown",
        "txt",
        "help",
        "NvimTree",
        "git",
        "TelescopePrompt",
        "undotree",
        "", -- for all buffers without a file type
      },
      buftype_exclude = { "terminal", "nofile" },
      show_current_context = true,
      context_patterns = {
        "class",
        "function",
        "method",
        "block",
        "list_literal",
        "selector",
        "^if",
        "^table",
        "if_statement",
        "while",
        "for",
      },
    }
  end,
}