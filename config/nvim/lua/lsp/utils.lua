local M = {}

function M.toggle_format_on_save()
  O.format_on_save = not O.format_on_save
end

function M.format_on_save()
  if O.format_on_save then
    M.format_sync(false)
  end
end

function M.format_sync(display_messages)
  display_messages = display_messages ~= false
  vim.lsp.buf.format { timeout_ms = 5000 }
  if display_messages then print("Format done.") end
end

return M
