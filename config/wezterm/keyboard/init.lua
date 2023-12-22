local wezterm = require("wezterm")
local tbl = require("utils.tables")

local config = {}

config.disable_default_key_bindings = true

local keys = {}

tbl.concat(keys, require("keyboard.rename"))
tbl.concat(keys, require("keyboard.movement"))

config.keys = keys

wezterm.log_info(config)

return config
