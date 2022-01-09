local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local LampToggle = require "ui.control_center.controls.lamp"

local control_center = awful.popup {
  widget = {
    {
      {
        font = beautiful.font_name .. " 50",
        format = "%H:%M",
        align = "center",
        widget = wibox.widget.textclock,
      },
      {
        {
          widget = awful.widget.watch("fortune -s", 600),
          align = "center",
        },
        widget = wibox.container.background,
        fg = beautiful.fg_dark,
      },
      {
        {
          {
            {
              {
                widget = require "ui.widget.vol_slider",
              },
              {
                widget = require "ui.widget.bri_slider",
              },
              layout = wibox.layout.flex.vertical,
              spacing = 10,
            },
            margins = 20,
            widget = wibox.container.margin,
          },
          widget = wibox.container.background,
          bg = beautiful.bg_normal,
          shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 9)
          end,
          forced_height = 110,
        },
        {
          {
            {
              { widget = require "ui.widget.cpu_circle" },
              margins = 20,
              widget = wibox.container.margin,
            },
            widget = wibox.container.background,
            bg = beautiful.bg_normal,
            shape = function(cr, width, height)
              gears.shape.rounded_rect(cr, width, height, 9)
            end,
            forced_height = 150,
          },
          {
            {
              { widget = require "ui.widget.ram_circle" },
              margins = 20,
              widget = wibox.container.margin,
            },
            widget = wibox.container.background,
            bg = beautiful.bg_normal,
            shape = function(cr, width, height)
              gears.shape.rounded_rect(cr, width, height, 9)
            end,
            forced_height = 150,
          },
          layout = wibox.layout.flex.horizontal,
          spacing = 20,
        },
        layout = wibox.layout.fixed.vertical,
        spacing = 20,
      },
      {
        {
          {
            { widget = LampToggle:new("light.shed_lamp", "bulb.svg") },
            { widget = LampToggle:new("light.erik_s_computer", "bulb.svg") },
            { widget = LampToggle:new("light.shed_lamp", "bulb.svg") },
            { widget = LampToggle:new("light.shed_lamp", "bulb.svg") },
            layout = wibox.layout.flex.horizontal,
            spacing = 15,
          },
          widget = wibox.container.margin,
          top = 20,
          bottom = 20,
          left = 35,
          right = 35,
        },
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        forced_height = 100,
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 9)
        end,
      },
      layout = wibox.layout.fixed.vertical,
      spacing = 20,
    },
    widget = wibox.container.margin,
    forced_width = 375,
    margins = 25,
  },
  placement = function(c)
    awful.placement.bottom_right(c, { margins = { bottom = 50, right = 10 } })
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
  control_center.screen = awful.screen.focused()
  control_center.visible = not control_center.visible
end

return toggle
