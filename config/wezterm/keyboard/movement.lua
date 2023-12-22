local wezterm = require("wezterm")
local act = wezterm.action

return {
	{ key = "{", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
}
