return {
  "rmagatti/goto-preview",
  config = function()
    local gp = require "goto-preview"

    gp.setup {
      preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
    }
  end,
}
