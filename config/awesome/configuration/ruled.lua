local awful = require "awful"
local ruled = require "ruled"
local naughty = require "naughty"
local wibox = require "wibox"
local gears = require "gears"

ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      maximized_horizontal = false,
      maximized_vertical = false,
      maximized = false,
    },
  }

  -- Floating clients.
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "Vncviewer",
      },
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true, placement = awful.placement.centered },
  }

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule {
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  }

  ruled.client.append_rule {
    rule = { class = "quake" },
    properties = {
      titlebars_enabled = false,
    },
  }

  ruled.client.append_rule {
    id = "vncviewer",
    rule_any = { class = { "Vncviewer" } },
    properties = {
      titlebars_enabled = false,
      screen = "DP-2",
      fullscreen = true,
    },
  }
end)

-- Notifications
naughty.connect_signal("request::display", function(n)
  n.timeout = 15
  n.position = "top_middle"

  local title = n.title or ""
  local message = n.message or n.text or ""

  -- Always safe bolding
  n.title = "<b>" .. title .. "</b>"

  if n.app_name == "Slack" then
    n.position = "top_right"

    -- Only rewrite title if we actually matched the pattern
    local channel = title:match("%[.+%] in #(.+)")
    if channel then
      n.title = "<b>#" .. channel .. "</b>"
    end

    local is_triggered = message:find("🔴", 1, true) ~= nil
    local is_resolved  = message:find("%*Resolved%*") ~= nil

    local label = channel and ("#" .. channel) or title
    local state_title = label

    if is_triggered then
      n.fg = "#222222"
      n.bg = "#BF616A"
      state_title = "Triggered"
    elseif is_resolved then
      n.bg = "#A3BE8C"
      state_title = "Resolved"
    end

    local pd_message
    if is_resolved then
    --  "PagerDuty: *Resolved* <*#477477: [test] bot-devops notification test*> "
      pd_message = message:match("PagerDuty:%s*%*Resolved%*%s*<%*#%d+:%s*(.-)%*%s*>")
    elseif is_triggered then
    --  "PagerDuty: 🔴 *<[test] bot-devops notification test>* Assigned: <Dummy>\n"
      pd_message = message:match("PagerDuty:.-%*<(.-)>%*")
    end

    if pd_message then
      n.timeout = 5
      n.text = "<b>" .. state_title .. "</b>: " .. pd_message
    end
  end

  n.widget_template = {
    {
      {
        {
          {
            naughty.widget.icon,
            {
              naughty.widget.title,
              naughty.widget.message,
              spacing = 4,
              layout = wibox.layout.fixed.vertical,
            },
            fill_space = true,
            spacing = 4,
            layout = wibox.layout.fixed.horizontal,
          },
          naughty.list.actions,
          spacing = 10,
          layout = wibox.layout.fixed.vertical,
        },
        margins = 20,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = naughty.container.background,
    },
    strategy = "max",
    width = 500,
    widget = wibox.container.constraint,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 9)
    end,
  }

  naughty.layout.box { notification = n, type = "notification" }
end)

naughty.expiration_paused = false
naughty.persistence_enabled = false

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)
