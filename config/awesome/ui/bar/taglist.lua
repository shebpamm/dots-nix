return function(s)
  local awful = require "awful"
  local bling = require "modules.bling"
  local gears = require "gears"
  local wibox = require "wibox"
  local beautiful = require "beautiful"

  local theme = beautiful.get()


  bling.widget.tag_preview.enable {
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
      awful.placement.bottom_left(c, {
        margins = {
          bottom = 50,
          left = 20,
        },
      })
    end,
  }
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end),
    },
    style = {
      shape = function(cr, width, height)

        local adjusted_size = math.floor(math.min(width, height)*1/math.sqrt(2)*0.8)

        gears.shape.rectangle(cr, adjusted_size, adjusted_size)
        cr:translate(adjusted_size/2, height/2)
        cr:rotate(math.rad(45))
        cr:translate(adjusted_size/-2, height/-2)
        cr:translate(-9, -3)
      end,
    },
    widget_template = {
      {
        {
          id = "inner_diamond",
          bg = theme.taglist_fg_empty,
          widget = wibox.container.background,
          forced_height = 10,
          forced_width = 12,
          shape = function(cr, width, height)
            gears.shape.hexagon(cr, 10, 10)
            cr:translate(-1.5, -5)
          end,
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:connect_signal("mouse::enter", function()
          if #c3:clients() > 0 then
            awesome.emit_signal("bling::tag_preview::update", c3)
            awesome.emit_signal("bling::tag_preview::visibility", s, true)
          end
        end)
        self:connect_signal("mouse::leave", function()
          awesome.emit_signal("bling::tag_preview::visibility", s, false)

          if self.has_backup then
            self.bg = self.backup
          end
        end)
      end,
      update_callback = function(self, t, index, tags)
        local diamond = self:get_children_by_id('inner_diamond')[1]
        if t.selected then
          diamond.bg = theme.taglist_fg_focus
        elseif #t:clients() > 0 then
          diamond.bg = theme.taglist_fg_occupied
        else
          diamond.bg = theme.taglist_fg_empty

        end
      end,
    },
  }
end
