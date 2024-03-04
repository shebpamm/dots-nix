local M = {}

local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  b.code_actions.refactoring,
  b.diagnostics.ruff,
  b.diagnostics.sqlfluff,
  b.diagnostics.tfsec,
  b.diagnostics.yamllint,
  b.formatting.astyle,
  b.formatting.black,
  b.formatting.isort,
  b.formatting.prettier,
  b.formatting.sqlfluff,
  b.formatting.stylua,
  b.formatting.terraform_fmt,
  b.formatting.yamlfmt,
  b.formatting.nixpkgs_fmt,
}

local default_overrides = {
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
  prettier = {
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
