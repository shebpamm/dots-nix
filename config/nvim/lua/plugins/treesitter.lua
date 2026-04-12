local function add_custom_parsers()
  parsers = require "nvim-treesitter.parsers"
  parsers.gotmpl = {
    install_info = {
      url = "https://github.com/ngalaiko/tree-sitter-go-template",
      files = { "src/parser.c" },
    },
    filetype = "gotmpl",
    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
  }

  parsers.jinja2 = {
    install_info = {
      url = "https://github.com/dbt-labs/tree-sitter-jinja2",
      branch = "main",
      files = { "src/parser.c" },
    },
    filetype = "j2",
  }

  -- add markdown (credit: folke)
  parsers.markdown = {
    install_info = {
      url = "https://github.com/ikatyang/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
    },
  }
end

local function ensure_parsers()
  local ensure_installed = O.treesitter.ensure_installed

  local already_installed = require("nvim-treesitter.config").get_installed()
  local parsers_to_install = vim
    .iter(ensure_installed)
    :filter(function(lang)
      return not vim.tbl_contains(already_installed, lang)
    end)
    :totable()
  require("nvim-treesitter").install(parsers_to_install)
end

local function bind_textobjects()
  local function select(object)
    s = require "nvim-treesitter-textobjects.select"
    return function()
      s.select_textobject(object)
    end
  end

  vim.keymap.set({ "x", "o" }, "af", select "@function.outer", { desc = "Select around function" })
  vim.keymap.set({ "x", "o" }, "if", select "@function.inner", { desc = "Select inside function" })

  vim.keymap.set({ "x", "o" }, "aC", select "@class.outer", { desc = "Select around class" })
  vim.keymap.set({ "x", "o" }, "iC", select "@class.inner", { desc = "Select inside class" })

  vim.keymap.set({ "x", "o" }, "ac", select "@conditional.outer", { desc = "Select around conditional" })
  vim.keymap.set({ "x", "o" }, "ic", select "@conditional.inner", { desc = "Select inside conditional" })

  vim.keymap.set({ "x", "o" }, "ae", select "@block.outer", { desc = "Select around block" })
  vim.keymap.set({ "x", "o" }, "ie", select "@block.inner", { desc = "Select inside block" })

  vim.keymap.set({ "x", "o" }, "al", select "@loop.outer", { desc = "Select around loop" })
  vim.keymap.set({ "x", "o" }, "il", select "@loop.inner", { desc = "Select inside loop" })

  vim.keymap.set({ "x", "o" }, "as", select "@statement.outer", { desc = "Select around statement" })
  vim.keymap.set({ "x", "o" }, "is", select "@statement.inner", { desc = "Select inside statement" })

  vim.keymap.set({ "x", "o" }, "ad", select "@comment.outer", { desc = "Select around comment" })

  vim.keymap.set({ "x", "o" }, "au", select "@call.outer", { desc = "Select around call" })
  vim.keymap.set({ "x", "o" }, "iu", select "@call.inner", { desc = "Select inside call" })

  vim.keymap.set({ "x", "o" }, "aa", select "@parameter.outer", { desc = "Select around parameter" })
  vim.keymap.set({ "x", "o" }, "ia", select "@parameter.inner", { desc = "Select inside parameter" })

  vim.keymap.set({ "x", "o" }, "ak", select "@assignment.lhs", { desc = "Select assignment LHS" })
  vim.keymap.set({ "x", "o" }, "ik", select "@assignment.lhs", { desc = "Select assignment LHS (inner)" })

  vim.keymap.set({ "x", "o" }, "av", select "@assignment.rhs", { desc = "Select assignment RHS" })
  vim.keymap.set({ "x", "o" }, "iv", select "@assignment.rhs", { desc = "Select assignment RHS (inner)" })
end

local function setup()
  local ts = require "nvim-treesitter"

  ensure_parsers()
  vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate", callback = add_custom_parsers })

  local select = require "vim.treesitter._select"

  vim.keymap.set({ "x" }, "<BS>", function()
    select.select_child(vim.v.count1)
  end, { desc = "wip" })

  vim.keymap.set({ "x", "n" }, "<Enter>", function()
    select.select_parent(vim.v.count1)
  end, { desc = "wip" })

  ts.setup {
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  }

  bind_textobjects()

  vim.treesitter.language.register("json", "jsonc")
  vim.treesitter.language.register("rasi", "css")
  vim.treesitter.language.register("terraform-vars", "hcl")
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  config = setup,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
      "windwp/nvim-ts-autotag",
      opts = {},
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup {
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        }
        vim.g.skip_ts_context_commentstring_module = true
      end,
    },
  },
}
