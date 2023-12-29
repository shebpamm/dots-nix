local wezterm = require("wezterm")
local tbl = require("utils.tables")

local config = {}

config.disable_default_key_bindings = false

local keys = {}

tbl.concat(keys, require("keyboard.rename"))
tbl.concat(keys, require("keyboard.movement"))

config.keys = keys

wezterm.log_info(config)

return config
