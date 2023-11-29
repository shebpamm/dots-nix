local awful = require "awful"
terminal = "wezterm"
browser = "google-chrome-stable --remote-debugging-address=127.0.0.1 --remote-debugging-port=9222"
editor = os.getenv "EDITOR" or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

require "configuration.ruled"
require "configuration.bound"
require "configuration.layout"
