---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local rnotification = require "ruled.notification"
local dpi = xresources.apply_dpi
local theme_path = require("gears").filesystem.get_configuration_dir() .. "themes/lake/"
local themes_path = require("gears").filesystem.get_themes_dir()
local gcolor = require("gears").color

local c = require("themes.lake.colors").dark

local theme = {}

theme.font_name = "JetBrainsMono Nerd Font"
theme.font = theme.font_name .. " 8"

theme.none = "#00000000"

theme.bg_normal = c.nord0
theme.bg_focus = c.nord2
theme.bg_dark = c.nord0
theme.bg_urgent = c.nord1
theme.bg_minimize = c.nord2
theme.bg_systray = theme.bg_normal

theme.fg_normal = c.nord4
theme.fg_focus = c.nord6
theme.fg_urgent = c.nord6
theme.fg_minimize = c.nord4
theme.fg_dark = c.nord4

theme.fg_bat = c.nord7
theme.fg_time = c.nord9

theme.useless_gap = dpi(10)
theme.border_width = dpi(0)
theme.border_color_normal = c.nord10
theme.border_color_active = c.nord7
theme.border_color_marked = c.nord8

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.taglist_bg_empty = c.nord4
theme.taglist_bg_occupied = c.nord4
theme.taglist_bg_focus = c.nord4
theme.taglist_fg_empty = c.nord0
theme.taglist_fg_occupied = c.nord2
theme.taglist_fg_focus = c.nord8

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.bg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- control center
theme.control_center_button_bg = c.nord9
theme.control_center_button_bg_off = c.nord2
theme.control_center_mem_used = c.nord12
theme.control_center_cpu_active = c.nord14
theme.control_center_vol_slider_active = c.nord9
theme.control_center_bri_slider_active = c.nord9

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_font = "arimo:mono 16"
theme.notification_bg = theme.fg

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width = dpi(150)

theme.titlebar_close_button_normal = theme_path .. "close_normal.svg"
theme.wallpaper = theme_path .. "background.png"

theme.layout_floating = gcolor.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg_normal)
theme.layout_tile = gcolor.recolor_image(themes_path .. "default/layouts/tile.png", theme.fg_normal)
theme.layout_spiral = gcolor.recolor_image(themes_path .. "default/layouts/spiral.png", theme.fg_normal)

theme.task_preview_widget_border_radius = 5
theme.task_preview_widget_bg = theme.bg_dark
theme.task_preview_widget_border_color = theme.fg_normal
theme.task_preview_widget_border_width = 0
theme.task_preview_widget_margin = 10

theme.tag_preview_widget_border_radius = 5
theme.tag_preview_client_border_radius = 5
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.bg_focus
theme.tag_preview_client_border_color = theme.border_color_normal
theme.tag_preview_client_border_width = 3
theme.tag_preview_widget_bg = theme.bg_dark
theme.tag_preview_widget_border_color = theme.border_color_normal
theme.tag_preview_widget_border_width = 0
theme.tag_preview_widget_margin = 10

theme.hotkeys_fg = c.nord6
theme.hotkeys_modifiers_fg = c.nord14

-- For tabbed only
theme.tabbed_spawn_in_tab = false

-- For tabbar in general
theme.tabbar_ontop = false
theme.tabbar_radius = 5
theme.tabbar_style = "default"
theme.tabbar_font = theme.font
theme.tabbar_size = 40
theme.tabbar_position = "top"
theme.tabbar_bg_normal = theme.bg_normal
theme.tabbar_fg_normal = theme.fg_normal
theme.tabbar_bg_focus = theme.bg_focus
theme.tabbar_fg_focus = theme.fg_focus
theme.tabbar_disable = false

theme.tabbar_color_close = "#f9929b"
theme.tabbar_color_min = "#fbdf90"
theme.tabbar_color_float = "#ccaced"

theme.window_switcher_widget_bg = theme.bg_dark
theme.window_switcher_widget_border_width = 0
theme.window_switcher_widget_border_radius = 5
theme.window_switcher_clients_spacing = 20
theme.window_switcher_client_icon_horizontal_spacing = 5
theme.window_switcher_client_width = 150
theme.window_switcher_client_height = 250
theme.window_switcher_client_margins = 10
theme.window_switcher_thumbnail_margins = 10
theme.window_switcher_name_margins = 10
theme.window_switcher_name_forced_width = 200
theme.window_switcher_name_normal_color = theme.fg_normal
theme.window_switcher_name_focus_color = "#89b482"
theme.window_switcher_icon_width = 40

-- bling window swallowing
theme.parent_filter_list = { "firefox", "Gimp" }
theme.child_filter_list = {}
theme.swallowing_filter = true

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule {
    rule = { urgency = "critical" },
    properties = { bg = "#ff0000", fg = "#ffffff" },
  }
end)

return theme
