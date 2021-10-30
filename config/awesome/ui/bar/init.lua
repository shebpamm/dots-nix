local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

screen.connect_signal("request::desktop_decoration", function(s)
  local l = awful.layout.suit
  awful.tag(
    { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    s,
    { l.floating, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile }
  )
  awful.popup({
    bg = beautiful.none,
    placement = function(c)
      (awful.placement.bottom + awful.placement.maximize_horizontally)(
        c,
        { margins = { bottom = 10, left = 10, right = 20 } }
      )
    end,
    shape = gears.shape.rect,
    widget = {
      {
        {
          {
            widget = require "ui.bar.taglist"(s),
          },
          widget = wibox.container.margin,
          margins = 5,
        },
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 9)
        end,
      },
      {
        widget = wibox.container.place,
        halign = "center",
        {
          widget = require "ui.bar.tasklist"(s),
        },
      },
      {
        {
          bg = beautiful.bg_normal,
          fg = beautiful.fg_bat,
          shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 9)
          end,
          widget = wibox.container.background,
          {
            {
              widget = awful.widget.watch("status bat", 30),
            },
            left = 7,
            right = 7,
            top = 5,
            bottom = 5,
            widget = wibox.container.margin,
          },
        },
        {
          bg = beautiful.bg_normal,
          fg = beautiful.fg_time,
          shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 9)
          end,
          widget = wibox.container.background,
          {
            widget = wibox.widget.textclock,
          },
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
      },
      layout = wibox.layout.align.horizontal,
      forced_height = 30,
    },
  }):struts { bottom = 40 }
end)
