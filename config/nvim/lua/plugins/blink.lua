local emoji_provider = {
  module = "blink-emoji",
  name = "Emoji",
  score_offset = 15, -- Tune by preference
  opts = {
    insert = true, -- Insert emoji (default) or complete its name
    ---@type string|table|fun():table
    trigger = function()
      return { ":" }
    end,
  },
  should_show_items = function()
    return vim.tbl_contains(
      -- Enable emoji completion only for git commits and markdown.
      -- By default, enabled for all file-types.
      { "gitcommit", "markdown" },
      vim.o.filetype
    )
  end,
}

return {
  "saghen/blink.cmp",
  build = function()
    require("blink.cmp").build():pwait()
  end,
  dependencies = {
    "saghen/blink.lib",
    "rafamadriz/friendly-snippets",
    -- "moyiz/blink-emoji.nvim",
  },

  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    sources = {
      -- default = { "emoji" },
      providers = {
        emoji = emoji_provider,
      },
    },
    keymap = {
      preset = "super-tab",
    },
    appearance = { nerd_font_variant = "mono" },
  },
}
