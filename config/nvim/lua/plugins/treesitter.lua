local function setup()
  local ts_config = require "nvim-treesitter.configs"
  local ts_parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  ts_parser_configs.gotmpl = {
    install_info = {
      url = "https://github.com/ngalaiko/tree-sitter-go-template",
      files = { "src/parser.c" },
    },
    filetype = "gotmpl",
    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
  }

  ts_config.setup {
    ensure_installed = O.treesitter.ensure_installed,
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = false },
    playground = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        node_decremental = "<BS>",
      },
    },
    rainbow = {
      enable = true,
      query = "rainbow-parens",
      strategy = require("ts-rainbow").strategy.global,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["au"] = "@call.outer",
          ["iu"] = "@call.inner",

        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<localleader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<localleader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
      },
    },
  }

  local lang_register = vim.treesitter.language.register
  lang_register("json", "jsonc")
  lang_register("rasi", "css")
  lang_register("terraform-vars", "hcl")

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  parser_config.jinja2 = {
    install_info = {
      url = "https://github.com/dbt-labs/tree-sitter-jinja2",
      branch = "main",
      files = { "src/parser.c" },
    },
    filetype = "j2",
  }

  -- add markdown (credit: folke)
  parser_config.markdown = {
    install_info = {
      url = "https://github.com/ikatyang/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = setup,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "windwp/nvim-ts-autotag" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "HiPhish/nvim-ts-rainbow2" },
    {
      "nvim-treesitter/playground",
      keys = { "<localleader>s" },
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
      config = function()
        require("which-key").register {
          ["<localleader>s"] = {
            "<CMD>TSHighlightCapturesUnderCursor<CR>",
            "syntax highlight group under the cursor",
          },
        }
      end,
    },
  },
}
