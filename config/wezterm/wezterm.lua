local wezterm = require 'wezterm'
local tbl = require 'utils.tables'

local config = {}

config = tbl.merge(config, require 'themes.catppuccin')
config = tbl.merge(config, require 'keyboard')

config.scrollback_lines = 3500

return config
