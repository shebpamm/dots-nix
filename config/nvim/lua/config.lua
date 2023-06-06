-- config file for my neovim configuration
-- meta, aint it?

O = {
  colorscheme = "catppuccin",
  leader = " ",
  localleader = ",",
  borders = "single",
  format_on_save = false,
  icon_colors = false,
  smart_close = "help,startuptime,qf,lspinfo,packer,tsplayground", -- windows to close with 'q'
  lsp_log_level = "INFO",
  icons = {
    kinds = {
      Class = "ﴯ ",
      Color = " ",
      Constant = "",
      Constructor = " ",
      Enum = "練",
      EnumMember = " ",
      Event = " ",
      Field = "識",
      File = "",
      Folder = " ",
      Function = " ",
      Interface = "ﰮ ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = "",
      Property = " ",
      Reference = "渚",
      Snippet = " ",
      Struct = "פּ ",
      Text = " ",
      TypeParameter = " ",
      Unit = "塞",
      Value = " ",
      Variable = "",
    },
  },
  treesitter = {
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "cpp",
      "css",
      "dart",
      "go",
      "hcl",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "rust",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vue",
      "yaml",
      "nix",
      -- "markdown",
    },
  },
  terminal = {
    direction = "horizontal",
  },
}

-- {{{ source project config
if vim.fn.filereadable(vim.fn.getcwd() .. "/.nvimrc.lua") == 1 then
  vim.cmd("luafile" .. vim.fn.getcwd() .. "/.nvimrc.lua")
end
-- }}}
