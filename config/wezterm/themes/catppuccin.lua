local wezterm = require 'wezterm'

return {
  color_scheme = "Catppuccin Frappe",
  font = wezterm.font_with_fallback {
    "Fira Code",
    "karstakuvakkeet"
  },
  tab_bar_at_bottom = true,
}
