local M = {}

function M.setup()
  utils.command("ToggleFormatOnSave", require("lsp.utils").toggle_format_on_save)
  utils.command("LspLog", "edit " .. vim.lsp.log.get_filename())
end

return M
