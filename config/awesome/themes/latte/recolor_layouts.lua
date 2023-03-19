local c = require("themes.latte.colors")
local gcolor = require("gears").color

local themes_path = require("gears").filesystem.get_themes_dir()
local bling_path = require("gears").filesystem.get_configuration_dir() .. "modules/bling/icons/layouts/"

local machi = require "../../modules/layout-machi"

theme = {}

local icon_color = c.base

theme.layout_fairh = gcolor.recolor_image(themes_path.."default/layouts/fairhw.png", icon_color)
theme.layout_fairv = gcolor.recolor_image(themes_path.."default/layouts/fairvw.png", icon_color)
theme.layout_floating  = gcolor.recolor_image(themes_path.."default/layouts/floatingw.png", icon_color)
theme.layout_magnifier = gcolor.recolor_image(themes_path.."default/layouts/magnifierw.png", icon_color)
theme.layout_max = gcolor.recolor_image(themes_path.."default/layouts/maxw.png", icon_color)
theme.layout_fullscreen = gcolor.recolor_image(themes_path.."default/layouts/fullscreenw.png", icon_color)
theme.layout_tilebottom = gcolor.recolor_image(themes_path.."default/layouts/tilebottomw.png", icon_color)
theme.layout_tileleft   = gcolor.recolor_image(themes_path.."default/layouts/tileleftw.png", icon_color)
theme.layout_tile = gcolor.recolor_image(themes_path.."default/layouts/tilew.png", icon_color)
theme.layout_tiletop = gcolor.recolor_image(themes_path.."default/layouts/tiletopw.png", icon_color)
theme.layout_spiral  = gcolor.recolor_image(themes_path.."default/layouts/spiralw.png", icon_color)
theme.layout_dwindle = gcolor.recolor_image(themes_path.."default/layouts/dwindlew.png", icon_color)
theme.layout_cornernw = gcolor.recolor_image(themes_path.."default/layouts/cornernww.png", icon_color)
theme.layout_cornerne = gcolor.recolor_image(themes_path.."default/layouts/cornernew.png", icon_color)
theme.layout_cornersw = gcolor.recolor_image(themes_path.."default/layouts/cornersww.png", icon_color)
theme.layout_cornerse = gcolor.recolor_image(themes_path.."default/layouts/cornersew.png", icon_color)

-- Bling layouts
theme.layout_mstab = gcolor.recolor_image(bling_path .. "mstab.png", icon_color)
theme.layout_centered = gcolor.recolor_image(bling_path .. "centered.png", icon_color)
theme.layout_equalarea = gcolor.recolor_image(bling_path .. "equalarea.png", icon_color)
theme.layout_deck = gcolor.recolor_image(bling_path .. "deck.png", icon_color)

-- Layout machi
theme.layout_machi = gcolor.recolor_image(machi.icon_raw, icon_color)

return theme
