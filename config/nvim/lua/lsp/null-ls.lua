local M = {}

require("mason-null-ls").setup { automatic_installation = true }

local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  b.code_actions.refactoring,
  b.diagnostics.flake8,
  b.diagnostics.pydocstyle,
  b.diagnostics.shellcheck,
  b.diagnostics.sqlfluff,
  b.diagnostics.tfsec,
  b.diagnostics.yamllint,
  b.formatting.astyle,
  b.formatting.black,
  b.formatting.isort,
  b.formatting.prettierd,
  b.formatting.sqlfluff,
  b.formatting.stylua,
  b.formatting.terraform_fmt,
  b.formatting.yamlfmt,
  b.formatting.nixpkgs_fmt,
}

local default_overrides = {
  flake8 = {
    filter = function(diagnostic)
      return diagnostic.code ~= "E501" -- Skip "line too long" errors
    end,
  },
  yamllint = {
    filter = function(d)
      if d.code == "document-start" then
        return false
      end
      if d.code == "line-length" then
        return false
      end

      return true
    end,
  },
  astyle = {
    extra_filetypes = { "groovy", "Jenkinsfile" },
  },
  sqlfluff = {
    extra_args = { "--dialect", "postgres" }, -- change to your dialect
  },
  prettierd = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
    },
  },
}

local function configure_sources(srcs, defaults)
  local configured_sources = {}
  local global_overrides = vim.g.null_ls_overrides or {}
  local overrides = vim.tbl_extend("force", defaults, global_overrides)
  for _, src in pairs(srcs) do
    local override = overrides[src.name]
    if override == nil then
      table.insert(configured_sources, src)
    else
      table.insert(configured_sources, src.with(override))
    end
  end

  return configured_sources
end

M.setup = function()
  null_ls.setup {
    debounce = 150,
    debug = true,
    sources = configure_sources(sources, default_overrides),
  }
end

return M
