local wezterm = require 'wezterm'
local tbl = require 'utils.tables'

local config = {}

config = tbl.merge(config, require 'themes.catppuccin')

return config
