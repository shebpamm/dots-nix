local awful = require "awful"
local bling = require "modules.bling"

local l = awful.layout.suit

local machi = require "../modules/layout-machi"

awful.layout.layouts = {
  machi.default_layout,
  l.tile,
  l.spiral,
  bling.layout.mstab,
  bling.layout.centered,
  bling.layout.equalarea,
  bling.layout.deck,
  l.floating,
}
