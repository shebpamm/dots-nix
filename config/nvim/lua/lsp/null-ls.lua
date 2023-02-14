local M = {}

require("mason-null-ls").setup { automatic_installation = true }

M.setup = function()
  local null_ls = require "null-ls"
  local b = null_ls.builtins

  null_ls.setup {
    debounce = 150,
    debug = false,
    sources = {
      b.diagnostics.flake8.with {
        filter = function(diagnostic)
          return diagnostic.code ~= "E501" -- Skip "line too long" errors
        end,
      },
      b.diagnostics.yamllint.with {
        filter = function(d)
          if d.code == "document-start" then return false end
          if d.code == "line-length" then return false end

          return true
        end,
      },
      b.formatting.astyle.with {
        extra_filetypes = { "groovy", "Jenkinsfile" },
      },
      b.diagnostics.sqlfluff.with {
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      },
      b.formatting.sqlfluff.with {
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      },
      b.code_actions.refactoring,
      b.diagnostics.pydocstyle,
      b.diagnostics.shellcheck,
      b.formatting.black,
      b.formatting.isort,
      b.formatting.prettierd,
      b.formatting.stylua,
      b.formatting.terraform_fmt,
      b.formatting.yamlfmt,
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
