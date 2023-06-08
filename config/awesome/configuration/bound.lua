local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local machi = require "../modules/layout-machi"

require "awful.hotkeys_popup.keys"

-- Mouse bindings
awful.mouse.append_global_mousebindings {
  awful.button({}, 3, function()
    Menu.main:toggle()
  end),
}

-- Key bindings

-- General Utilities
awful.keyboard.append_global_keybindings {
  awful.key({}, "Print", function()
    awful.spawn "scr screen"
  end),
  awful.key({ "Shift" }, "Print", function()
    awful.spawn "scr selection"
  end),
  awful.key({ "Control" }, "Print", function()
    awful.spawn "scr window"
  end),
  awful.key({ modkey }, "Print", function()
    awful.spawn "scr screentoclip"
  end),
  awful.key({ modkey, "Shift" }, "Print", function()
    awful.spawn "scr selectiontoclip"
  end),
  awful.key({ modkey, "Control" }, "Print", function()
    awful.spawn "scr windowtoclip"
  end),
}

-- General Awesome keys
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "w", function()
    Menu.main:show()
  end, {
    description = "show main menu",
    group = "awesome",
  }),
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, {
    description = "open a terminal",
    group = "launcher",
  }),
  awful.key({ modkey }, "z", function()
    awful.screen.focused().quake:toggle()
  end, {
    description = "toggle dropdown terminal",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "Return", function()
    awful.spawn(browser)
  end, {
    description = "open a browser",
    group = "launcher",
  }),
  awful.key({ modkey }, "d", function()
    awful.spawn "rofi -modes drun,' Code:rofi-ykman',window -show drun"
  end, {
    description = "run prompt",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "/", function()
    awful.spawn "fish -c '~/lock.sh'"
  end, {
    description = "run prompt",
    group = "launcher",
  }),
  awful.key({ modkey }, "a", function()
    require "ui.control_center"()
  end, {
    description = "toggle control center",
    group = "launcher",
  }),
  awful.key({ modkey }, "/", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
  end, {
    description = "show help",
    group = "awesome",
  }),
}

-- Media control keys
awful.keyboard.append_global_keybindings {
  awful.key({}, "XF86AudioPlay", function()
    awful.spawn "playerctl play-pause"
  end, { description = "view previous", group = "tag" }),
  awful.key({}, "XF86AudioNext", function()
    awful.spawn "playerctl next"
  end, { description = "view next", group = "tag" }),
  awful.key({}, "XF86AudioPrev", function()
    awful.spawn "playerctl previous"
  end, { description = "go back", group = "tag" }),
}

-- Tags related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey, "Shift" }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
}

-- Focus related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, {
    description = "focus next by index",
    group = "client",
  }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, {
    description = "focus previous by index",
    group = "client",
  }),
  awful.key({ modkey }, "Tab", function()
    awful.screen.focus_relative(1)
  end, {
    description = "switch focus of screen",
    group = "client",
  }),
  awful.key({ modkey }, "Escape", function(c)
    local master = awful.client.getmaster(awful.screen.focused())
    local last_focused_window = awful.client.focus.history.get(awful.screen.focused(), 1, nil)
    if client.focus == master then
      if not last_focused_window then
        return
      end
      client.focus = last_focused_window
    else
      client.focus = master
    end
  end, {
    description = "switch focus between master and last client",
    group = "client",
  }),
}

-- Layout related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client by index",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client by index",
    group = "client",
  }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, {
    description = "increase master width factor",
    group = "layout",
  }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, {
    description = "decrease master width factor",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, {
    description = "increase the number of columns",
    group = "layout",
  }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, {
    description = "decrease the number of columns",
    group = "layout",
  }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, {
    description = "select next",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, {
    description = "select previous",
    group = "layout",
  }),
  awful.key({ modkey }, ",", function()
    machi.switcher.start()
  end, {
    description = "open machi layout switcher",
    group = "layout",
  }),
  awful.key({ modkey }, ".", function()
    machi.default_editor.start_interactive()
  end, {
    description = "edit the current layout as machi layout",
    group = "layout",
  }),
}

awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers = { modkey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  },
}

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  }
end)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings {
    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {
      description = "toggle fullscreen",
      group = "client",
    }),
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, {
      description = "close",
      group = "client",
    }),
    awful.key(
      { modkey, "Control" },
      "space",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, {
      description = "move to master",
      group = "client",
    }),
    awful.key({ modkey }, "o", function(c)
      c:move_to_screen()
    end, {
      description = "move to screen",
      group = "client",
    }),
    awful.key({ modkey }, "t", function(c)
      c.ontop = not c.ontop
    end, {
      description = "toggle keep on top",
      group = "client",
    }),
    awful.key({ modkey }, "n", function(c)
      require "ui.notification_center.notif_popup"()
    end, {
      description = "minimize",
      group = "client",
    }),
    awful.key({ modkey }, "m", function(c)
      awful.spawn "clipcat-menu"
    end, {
      description = "(un)maximize",
      group = "client",
    }),
    awful.key({ modkey, "Control" }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, {
      description = "(un)maximize vertically",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, {
      description = "(un)maximize horizontally",
      group = "client",
    }),
  }
end)
