local awful = require "awful"
local quake = require "modules.quake"

awful.screen.connect_for_each_screen(function(s)
  s.quake = quake({ app = "kitty", visible = false, height = 0.8, screen = s, extra = "-e tmux", argname="--class %s", name="quake", border=0 })
end)
