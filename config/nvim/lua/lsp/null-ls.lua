local M = {}

M.setup = function()
  local null_ls = require "null-ls"
  local b = null_ls.builtins

  null_ls.setup {
    debounce = 150,
    debug = false,
    sources = {
      b.diagnostics.flake8.with({
        filter = function(diagnostic)
          return diagnostic.code ~= "E501" -- Skip "line too long" errors
        end,
      }),
      b.code_actions.refactoring,
      b.diagnostics.pydocstyle,
      b.diagnostics.shellcheck,
      b.diagnostics.yamllint,
      b.formatting.black,
      b.formatting.isort,
      b.formatting.prettier_d_slim,
      b.formatting.stylua,
    },
    on_attach = function(client)
      if client.server_capabilities.document_formatting then
        utils.augroup("lsp_format", {
          {
            events = { "BufWritePre" },
            targets = { "<buffer>" },
            command = require("lsp.utils").format_on_save,
          },
        })
      end
    end,
  }
end

return M
