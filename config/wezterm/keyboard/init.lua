local wezterm = require 'wezterm'
local tbl = require 'utils.tables'

local config = {}

config = tbl.merge(config, require 'keyboard.tabs')

return config
