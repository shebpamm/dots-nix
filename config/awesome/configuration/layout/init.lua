local awful = require "awful"
local bling = require "modules.bling"
local machi = require "configuration.layout.machi"

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
