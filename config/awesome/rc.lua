pcall(require, "luarocks.loader")

require "awful.autofocus"
local beautiful = require "beautiful"
local naughty = require "naughty"
local gears = require "gears"

-- err handling
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  }
end)

-- truly beautiful
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/lake/theme.lua")

-- *gulp*
require("modules.bling").module.window_swallowing.start()

-- wallpaper
require "wallpaper"

-- config stuff
require "configuration"

-- signals
require "squeals"

-- user interfaces
require "ui"

naughty.notification {title = "kaka",message = "asdasd"}
