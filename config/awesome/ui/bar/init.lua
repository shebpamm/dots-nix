local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"
local machi_layouts = require "../../configuration/layout/machi"

local systray = wibox.widget.systray()
systray:set_screen(screen[screen.count()])
systray:set_horizontal(true)

local tray_widget = wibox.widget {
  bg = beautiful.bg_normal,
  fg = beautiful.fg_time,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 9)
  end,
  widget = wibox.container.background,
  {
    systray,
    left = 15,
    right = 15,
    top = 5,
    bottom = 5,
    widget = wibox.container.margin,
  },
}

local battery = wibox.widget {
  bg = beautiful.bg_normal,
  fg = beautiful.fg_bat,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 9)
  end,
  widget = wibox.container.background,
  {
    {
      widget = awful.widget.watch("stts bat", 30),
    },
    left = 7,
    right = 7,
    top = 5,
    bottom = 5,
    widget = wibox.container.margin,
  },
}

local time = wibox.widget {
  bg = beautiful.bg_normal,
  fg = beautiful.fg_time,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 9)
  end,
  widget = wibox.container.background,
  {
    widget = wibox.widget.textclock,
  },
}

function create_layoutbox(s)
  return wibox.widget {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_time,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 9)
    end,
    widget = wibox.container.background,
    {
      widget = wibox.container.margin,
      margins = 7.5,
      {
        widget = awful.widget.layoutbox {
          screen = s,
          buttons = {
            awful.button({}, 1, function()
              awful.layout.inc(1)
            end),
            awful.button({}, 3, function()
              awful.layout.inc(-1)
            end),
            awful.button({}, 4, function()
              awful.layout.inc(1)
            end),
            awful.button({}, 5, function()
              awful.layout.inc(-1)
            end),
          },
        },
      },
    },
  }
end

screen.connect_signal("request::desktop_decoration", function(s)
  local l = awful.layout.suit
  if s ~= screen.primary then
    local ml = machi_layouts.secondary
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, { ml, ml, ml, ml, ml, ml, ml, ml, ml })
  else
    awful.tag(
      { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
      s,
      { l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile }
    )
  end
  local anchor_side = (s == screen.primary and "bottom" or "top")
  awful.popup({
    bg = beautiful.none,
    placement = function(c)
      local anchor = (s == screen.primary and awful.placement.bottom or awful.placement.top)

      return (anchor + awful.placement.maximize_horizontally)(
        c,
        { margins = { [anchor_side] = 10, left = 20, right = 20 } }
      )
    end,
    shape = gears.shape.rect,
    screen = s,
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
        { widget = tray_widget },
        { widget = battery },
        { widget = time },
        { widget = create_layoutbox(s) },
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
      },
      layout = wibox.layout.align.horizontal,
      forced_height = 30,
    },
  }):struts { [anchor_side] = 40 }
end)
