-- lua/plugins/init.lua

-- {{{ bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  vim.cmd "packadd packer.nvim"
end
-- }}}

vim.cmd [[packadd packer.nvim]]

require("packer").startup {
  function(use)
    -- Core ----------------------------------------------------
    use { "wbthomason/packer.nvim", opt = true }
    use { "nvim-lua/plenary.nvim", module_pattern = "plenary.*" }
    use { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" }

    -- Colorschemes --------------------------------------------
    use "sainnhe/gruvbox-material"
    use "folke/tokyonight.nvim"
    use "shaunsingh/nord.nvim"
    use "b4skyx/serenade"
    use "mcchrish/zenbones.nvim"
    use "RRethy/nvim-base16" -- for base16 colorschemes

    -- UI ------------------------------------------------------

    -- bufferline
    use {
      "jose-elias-alvarez/buftabline.nvim",
      event = "BufEnter",
      config = [[require"plugins.buftabline"]],
    }

    -- file tree
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      keys = { "<C-n>" },
      config = [[require"plugins.nvim-tree"]],
    }

    -- dashboard
    use {
      "goolord/alpha-nvim",
      requires = "nvim-web-devicons",
      event = "VimEnter",
      config = [[require"plugins.dashboard"]],
    }

    -- indent lines
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("indent_blankline").setup {
          char = "|",
          context_char = "|",
          show_foldtext = false,
          show_first_indent_level = true,
          filetype_exclude = {
            "dashboard",
            "log",
            "gitcommit",
            "packer",
            "markdown",
            "txt",
            "help",
            "NvimTree",
            "git",
            "TelescopePrompt",
            "undotree",
            "", -- for all buffers without a file type
          },
          buftype_exclude = { "terminal", "nofile" },
          show_current_context = true,
          context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
          },
        }
      end,
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      wants = "project.nvim",
      config = [[require"plugins.telescope"]],
      requires = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-live-grep-raw.nvim" },
      },
    }

    --  LSP ----------------------------------------------------
    use {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
      config = [[require "lsp"]],
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      module = "null-ls",
      after = "nvim-lspconfig",
    }
    use {
      "folke/trouble.nvim",
      after = "nvim-lspconfig",
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("trouble").setup {
          auto_close = true,
        }
      end,
    }

    -- Treesitter ----------------------------------------------
    use {
      "nvim-treesitter/nvim-treesitter",
      config = [[require "plugins.treesitter"]],
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "windwp/nvim-ts-autotag" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
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

    -- Completion and Snippets ---------------------------------
    use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      requires = {
        { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
        {
          'ms-jpq/coq.thirdparty',
          branch = '3p',
        },
      },
      config = function()
        vim.g.coq_settings = {
          auto_start = 'shut-up',
          clients = {
            tree_sitter = { enabled = false },
            paths = { enabled = true, resolution = { 'file' } },
            snippets = { enabled = true, warn = {} },
            tags = { enabled = false },
          },
          keymap = { recommended = true },
          display = {
            preview = { positions = { north = 4, south = nil, west = 2, east = 3 } },
          },
        }
      end,
    }

    -- Project Management --------------------------------------
    use {
      "ahmedkhalf/project.nvim",
      keys = { "<leader>fp" },
      cmd = { "ProjectRoot" },
      config = function()
        require("project_nvim").setup {
          manual_mode = true,
          ignore_lsp = { "null-ls" },
          show_hidden = true,
          patterns = {
            "stylua.toml",
            "rc.lua",
            "config.org",
            "Makefile",
            "package.json",
            "Cargo.toml",
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "index.html",
            "!^.config",
          },
        }
      end,
    }

    -- Git -----------------------------------------------------
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      module = "gitsigns",
      config = [[require("plugins.gitsigns")]],
    }
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      module = "neogit",
    }

    -- Markdown ------------------------------------------------
    use {
      "plasticboy/vim-markdown",
      after = "tabular",
      requires = {
        "godlygeek/tabular",
        opt = true,
      },
      ft = "markdown",
    }

    -- Utilities -----------------------------------------------

    -- hmm... what was that mapped to?
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          plugins = {
            spelling = {
              enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            },
          },
        }
      end,
    }

    -- comments are nice
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    }

    -- terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      keys = { "<A-`>" },
      cmd = "ToggleTerm",
      config = [[require"plugins.terminal"]],
    }

    -- todo comments
    use {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
        require("todo-comments").setup {
          signs = false,
          colors = {
            error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#ea6962" },
            warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#d8a657" },
            info = { "LspDiagnosticsDefaultInformation", "#a9b665" },
            hint = { "LspDiagnosticsDefaultHint", "#89b482" },
            default = { "Identifier", "#7daea3" },
          },
        }
      end,
    }

    -- Zen -------------------------------
    use {
      "folke/zen-mode.nvim",
      cmd = { "ZenMode" },
      config = function()
        require("zen-mode").setup {
          twilight = { enabled = false },
          gitsigns = { enabled = true },
          kitty = { enabled = true },
        }
      end,
    }
    use {
      "folke/twilight.nvim",
      cmd = { "Twilight" },
    }

    -- textobjects
    -- use "wellle/targets.vim"
    -- use "machakann/vim-sandwich"

    -- highlight my logs
    use {
      "MTDL9/vim-log-highlighting",
      ft = "log",
    }

    -- undotree
    use {
      "mbbill/undotree",
      cmd = { "UndotreeToggle" },
    }

    -- highlight colors
    use {
      "norcalli/nvim-colorizer.lua",
      cmd = { "ColorizerToggle" },
      keys = { "<leader>tc" },
    }
  end,

  -- packer config
  log = { level = "info" },
  config = {
    display = {
      prompt_border = "single",
    },
    profile = {
      enable = true,
      threshold = 0,
    },
  },
}
