local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local ibl_opts = {
  indent = {
    char = "▎",
  },
  scope = {
    enabled = true,
    show_start = true,
    highlight = highlight,
  },
  exclude = {
    filetypes = {
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
    buftypes = {
      "terminal",
      "nofile",
    },
  },
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function()
      local hooks = require "ibl.hooks"

      require("ibl").setup(ibl_opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = highlight,
      }
    end,
  },
}
