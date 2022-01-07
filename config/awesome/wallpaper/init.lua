local gears = require('gears')
local beautiful = require('beautiful')

local theme = beautiful.get()

gears.wallpaper.maximized(theme.wallpaper, nil)
