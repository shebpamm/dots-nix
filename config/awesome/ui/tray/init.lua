local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

beautiful.systray_icon_spacing = 12

local systray = wibox.widget.systray()
systray:set_screen(screen[screen.count()])
systray:set_horizontal(false)
systray:set_base_size(16)

local tray_widget = wibox.widget {
  bg = beautiful.bg_normal,
  fg = beautiful.fg_time,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 9)
  end,
  widget = wibox.container.background,
  {
    systray,
    left = 10,
    top = 10,
    bottom = 10,
    right = 10,
    widget = wibox.container.margin,
  },
}

screen.connect_signal("request::desktop_decoration", function(s)
  local l = awful.layout.suit
  if s ~= screen.primary then
    awful.popup({
      bg = beautiful.none,
      placement = function(c)
        return (awful.placement.bottom_left)(c, { margins = { bottom = 20, left = 10, right = 10 } })
      end,
      shape = gears.shape.rect,
      screen = s,
      layout = wibox.layout.fixed.vertical,
      ontop = true,
      widget = {
        {
          widget = wibox.container.place,
          {
            widget = tray_widget,
          },
        },
        layout = wibox.layout.fixed.vertical,
      },
    }):struts { left = 40 }
  end
end)
