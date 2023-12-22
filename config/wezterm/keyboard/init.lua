local wezterm = require 'wezterm'
local tbl = require 'utils.tables'

local config = {}

config = tbl.merge(config, require 'keyboard.tabs')
config = tbl.merge(config, require 'keyboard.select')
config = tbl.merge(config, require 'keyboard.rename')

return config
