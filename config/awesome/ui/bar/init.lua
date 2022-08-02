local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"
local machi_layouts = require "../../configuration/layout/machi"

-- How much should corners be rounded
local round_radius = 9

-- Systray configuration
local systray = wibox.widget.systray()
systray:set_screen(screen[screen.count()])
systray:set_horizontal(true)

function rounded_rect(cr, width, height)
  return gears.shape.rounded_rect(cr, width, height, round_radius)
end

function tray_widget()
  local widget = wibox.widget {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_time,
    shape = rounded_rect,
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

  if awesome.systray() == 0 then
    widget.visible = false
  else
    widget.visible = true
  end

  systray:connect_signal('widget::redraw_needed', function()
    if awesome.systray() == 0 then
      widget.visible = false
    else
      widget.visible = true
    end
  end)

  return widget
end

function battery()
  local widget = wibox.widget {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_bat,
    shape = rounded_rect,
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
  
  awful.spawn.easy_async("stts bat", function(stdout, stderr, reason, exit_code)
    if exit_code == 2 then
      widget.visible = false
    end
  end)

  return widget
end

function time()
  local widget = wibox.widget {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_time,
    shape = rounded_rect,
    widget = wibox.container.background,
    {
      widget = wibox.widget.textclock,
    },
  }

  return widget
end

function create_layoutbox(s)
  return wibox.widget {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_time,
    shape = rounded_rect,
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

  -- Set layout depending on screen
  local dl
  if s ~= screen.primary then
     dl = machi_layouts.secondary -- Default Layout
  else
     dl = awful.layout.suit.tile  -- Default Layout
  end

  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, { dl, dl, dl, dl, dl, dl, dl, dl, dl })

  local anchor_side = (s == screen.primary and "bottom" or "top")

  local bar_startwidgets =
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
    shape = rounded_rect,
  }
  
  local bar_centerwidgets =
  {
    widget = wibox.container.place,
    halign = "center",
    {
      widget = require "ui.bar.tasklist"(s),
    },
  }
  
  local bar_endwidgets =
  {
    { widget = battery() },
    { widget = time() },
    { widget = create_layoutbox(s) },
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
  }

  if s == screen[screen.count()] then
    table.insert(bar_endwidgets, 1, { widget = tray_widget() })
  end

  awful.popup({
    bg = beautiful.none,
    shape = gears.shape.rect,
    screen = s,

    -- Place on bottom if primary, otherwise on top
    placement = function(c)
      local anchor = (s == screen.primary and awful.placement.bottom or awful.placement.top)

      return (anchor + awful.placement.maximize_horizontally)(
        c,
        { margins = { [anchor_side] = 10, left = 20, right = 20 } }
      )
    end,

    widget = {
      -- Dimensions & Placement
      layout = wibox.layout.align.horizontal,
      forced_height = 30,

      -- Left side
      bar_startwidgets,

      -- Center
      bar_centerwidgets,

      -- Right side
      bar_endwidgets,
    },
  }):struts { [anchor_side] = 40 } -- Add padding of 40 to anchor_side
end)
