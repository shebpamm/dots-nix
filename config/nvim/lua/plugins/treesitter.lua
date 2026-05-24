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

local function bind_textobjects(buf)
  local function select(object)
    s = require "nvim-treesitter-textobjects.select"
    return function()
      s.select_textobject(object)
    end
  end

  local function bind(key, callback, desc)
    vim.keymap.set({ "x", "o" }, key, callback, { buffer = buf, desc = desc })
  end

  bind("af", select "@function.outer", "Select around function")
  bind("if", select "@function.inner", "Select inside function")

  bind("aC", select "@class.outer", "Select around class")
  bind("iC", select "@class.inner", "Select inside class")

  bind("ac", select "@conditional.outer", "Select around conditional")
  bind("ic", select "@conditional.inner", "Select inside conditional")

  bind("ae", select "@block.outer", "Select around block")
  bind("ie", select "@block.inner", "Select inside block")

  bind("al", select "@loop.outer", "Select around loop")
  bind("il", select "@loop.inner", "Select inside loop")

  bind("as", select "@statement.outer", "Select around statement")
  bind("is", select "@statement.inner", "Select inside statement")

  bind("ad", select "@comment.outer", "Select around comment")

  bind("au", select "@call.outer", "Select around call")
  bind("iu", select "@call.inner", "Select inside call")

  bind("aa", select "@parameter.outer", "Select around parameter")
  bind("ia", select "@parameter.inner", "Select inside parameter")

  bind("ak", select "@assignment.lhs", "Select assignment LHS")
  bind("ik", select "@assignment.lhs", "Select assignment LHS (inner)")

  bind("av", select "@assignment.rhs", "Select assignment RHS")
  bind("iv", select "@assignment.rhs", "Select assignment RHS (inner)")
end

local function bind_select(buf)
  local select = require "vim.treesitter._select"

  vim.keymap.set({ "x" }, "<BS>", function()
    select.select_child(vim.v.count1)
  end, { buffer = buf, desc = "Select Inner" })

  vim.keymap.set({ "x", "n" }, "<Enter>", function()
    select.select_parent(vim.v.count1)
  end, { buffer = buf, desc = "Select Outer" })
end

local function setup_binds()
  local group = vim.api.nvim_create_augroup("TreesitterKeymaps", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local ft = args.match

      -- Skip quickfix buffers, otherwise enter select
      if ft == "qf" then
        return
      end

      parser = vim.treesitter.language.get_lang(ft)

      if not parser then
        return
      end

      bind_textobjects(args.buf)
      bind_select(args.buf)
    end,
  })
end

local function setup()
  local ts = require "nvim-treesitter"

  ensure_parsers()
  vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate", callback = add_custom_parsers })

  ts.setup {
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  }

  setup_binds()

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
