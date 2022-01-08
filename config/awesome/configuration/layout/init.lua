local awful = require "awful"
local bling = require "modules.bling"
local beautiful = require "beautiful"
local machi = require "configuration.layout.machi"

beautiful.layout_machi = machi.machi.get_icon()

local l = awful.layout.suit

awful.layout.layouts = {
  l.tile,
  l.spiral,
  bling.layout.mstab,
  bling.layout.centered,
  bling.layout.equalarea,
  bling.layout.deck,
  l.floating,
  machi.secondary,
}
