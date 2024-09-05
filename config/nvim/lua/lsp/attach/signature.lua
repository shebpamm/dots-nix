local M = {}

M.on_attach = function(client, bufnr)
  require "lsp_signature".on_attach({}, bufnr)
end

return M
