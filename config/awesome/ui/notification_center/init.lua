local awful = require "awful"
local beautiful = require "beautiful"
local naughty = require "naughty"
local gears = require "gears"
local wibox = require "wibox"

local LampToggle = require "ui.control_center.controls.lamp"

local window_margin = 25

local function get_height()
  return awful.screen.focused().geometry.height - 2*window_margin
end

local notification_center = awful.popup {
  widget = {
    widget = wibox.container.margin,
    margins = window_margin,
    {
      layout = wibox.layout.fixed.vertical,
      forced_width = 450,
      forced_height = get_height(),
      {
        widget = wibox.widget.textbox,
        markup = "<b>Notifications</b>",
        align = 'center',
        valign = 'top',
        font = beautiful.font .. " 30",
      },
      {
        widget = wibox.widget.separator,
        orientation = 'horizontal',
        thickness = 2,
        span_ratio = 0.9,
        color = beautiful.fg_bat,
        forced_height = 5,
      },
      {
        base_layout = wibox.widget {
          spacing_widget = wibox.widget {
            orientation = 'horizontal',
            widget = wibox.widget.separator,
            thickness = 2,
            span_ratio = 0.7,
            color = beautiful.fg_bat
          },
          forced_width = 450,
          spacing = 20,
          layout = wibox.layout.fixed.vertical
        },
        widget = naughty.list.notifications,
        widget_template = {
          widget = wibox.container.background,
          bg = beautiful.fg,
          {
            {
              resize_strategy = 'scale',
              forced_width = 48,
              widget = naughty.widget.icon,
            },
            {
              {
                widget = naughty.widget.title
              },
              naughty.widget.message,
              layout = wibox.layout.align.vertical,
            },
            spacing = 10,
            fill_space = true,
            layout = wibox.layout.fixed.horizontal,
          },
        },
      },
    },
    
  },
  placement = function(c)
    awful.placement.bottom_right(c, { })
  end,
  screen = awful.screen.focused(),
  ontop = true,
  visible = false,
  bg = beautiful.bg_dark,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
}

local function toggle()
  notification_center.screen = awful.screen.focused()
  notification_center.visible = not notification_center.visible
end

return toggle
