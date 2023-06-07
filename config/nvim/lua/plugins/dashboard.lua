local utils = require "utils"

-- Only load alpha if vim is started without arguments
-- This will proc lazy to also run the config function if it is started.
utils.augroup("alpha", {
  {
    events = { "VimEnter" },
    targets = { "*" },
    command = function()
      local should_skip = false
      if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            should_skip = true
            break
          end
        end
      end
      if not should_skip then
        require("alpha").start(true, require("alpha").default_config)
      end
    end,
  },
})

return {
  "goolord/alpha-nvim",
  dependencies = "nvim-web-devicons",
  cmd = "Alpha",
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
