return {
  "saghen/blink.cmp",
  build = 'cargo build --release',
  dependencies = { 'rafamadriz/friendly-snippets' },

  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
  }
}
