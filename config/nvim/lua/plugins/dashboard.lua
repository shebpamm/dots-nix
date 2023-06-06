return {
  "goolord/alpha-nvim",
  dependencies = "nvim-web-devicons",
  event = "VimEnter",
  config = function()
    local a = require "alpha"
    local d = require "alpha.themes.dashboard"
    local b = d.button
    local s = d.section

    s.buttons.val = {
      b("SPC s l", "  Last Session"),
      b("SPC s c", "  Directory Session"),
      b("SPC f f", "  Find File"),
      b("SPC f r", "  Recent Files"),
      b("SPC f w", "  Find Word"),
      b("SPC f p", "  Projects"),
      b("SPC ,", "  Edit Config"),
    }

    -- Skip spawning a shell to speedup start time
    local fortune_handle = io.popen "fortune -s"
    if not fortune_handle then
      s.footer.val = "No fortune today :("
    else
      s.footer.val = fortune_handle:read "*a"
      fortune_handle:close()
    end

    local opts = {
      layout = {
        { type = "padding", val = 1 },
        s.header,
        { type = "padding", val = 2 },
        s.buttons,
        { type = "padding", val = 4 },
        s.footer,
      },
      opts = {
        margin = 10,
      },
    }

    a.setup(opts)
  end,
}
