local goto = require('goto-preview')

local function goto_close_all()
  goto.close_all_win { skip_curr_window = false }
end

local function goto_definition_jump()
  goto_close_all()
  vim.lsp.buf.definition()
end

local goto_open_hook = function(bufr)
  vim.keymap.set("n", "q", goto_close_all, {
    noremap = true,
    silent = true,
    buffer = bufr,
  })
  vim.keymap.set("n", "g", goto_definition_jump, {
    noremap = true,
    silent = true,
    buffer = bufr,
  })
end

goto.setup({
  preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
  post_open_hook = goto_open_hook,
})
