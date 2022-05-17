local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

LampToggle = {}
LampToggle.__index = LampToggle

function LampToggle:new(entity_name, icon)
  icon = icon or "bulb.svg"

  local lamp = wibox.widget {
    {
      {
        widget = wibox.widget.imagebox,
        image = gears.filesystem.get_configuration_dir() .. "icons/" .. icon,
        stylesheet = " * { stroke: " .. beautiful.bg_normal .. " }",
        forced_width = 30,
        valign = "center",
        halign = "center",
      },
      widget = wibox.container.margin,
      margins = 10,
    },
    widget = wibox.container.background,
    bg = beautiful.control_center_button_bg,
    shape = function(cr, width, height)
      gears.shape.squircle(cr, width, height, 2, 0)
    end,
  }

  local on = beautiful.control_center_button_bg
  local off = beautiful.control_center_button_bg_off
  local s = false -- off
  lamp:buttons {
    awful.button({}, 1, function()
      s = not s
      if s then
        lamp.bg = off
        awful.spawn.with_shell("hass-cli state turn_off " .. entity_name)
      else
        lamp.bg = on
        awful.spawn.with_shell("hass-cli state turn_on " .. entity_name)
      end
    end),
  }

  return lamp
end

return LampToggle
