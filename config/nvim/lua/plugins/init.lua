-- lua/plugins/init.lua

-- {{{ Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup {
    -- Core ----------------------------------------------------
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "stevearc/dressing.nvim",

    -- Colorschemes --------------------------------------------
    "sainnhe/gruvbox-material",
    "folke/tokyonight.nvim",
    "shaunsingh/nord.nvim",
    "b4skyx/serenade",
    "mcchrish/zenbones.nvim",
    "RRethy/nvim-base16", -- for base16 colorschemes
    { "catppuccin/nvim", name = "catppuccin" },

    -- UI ------------------------------------------------------

    -- bufferline
    {
      "noib3/nvim-cokeline",
      dependencies = "kyazdani42/nvim-web-devicons",
      config = function() require "plugins.cokeline" end,
    },

    -- file tree
    {
      "ms-jpq/chadtree",
      branch = "chad",
      keys = { "<C-n>" },
      cmd = "CHADopen",
      config = function() require "plugins.chadtree" end,
    },

    -- speedy movement
    {
      "ggandor/leap.nvim",
      config = function() require "plugins.leap" end,
    },

    {
      "ggandor/leap-spooky.nvim",
      config = function()
        require("leap-spooky").setup()
      end,
    },

    -- dashboard
    {
      "goolord/alpha-nvim",
      dependencies = "nvim-web-devicons",
      event = "VimEnter",
      config = function() require "plugins.dashboard" end,
    },

    -- Better Quickfix
    { "kevinhwang91/nvim-bqf", ft = "qf" },

    -- indent lines
    {
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
    },

    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      config = function() require "plugins.telescope" end,
      dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim",   build = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-live-grep-raw.nvim" },
      },
    },

    --  LSP ----------------------------------------------------
    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
      config = function() require "lsp" end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      module = "null-ls",
    },
    {
      "folke/trouble.nvim",
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("trouble").setup {
          auto_close = true,
        }
      end,
    },

    {
      "lvimuser/lsp-inlayhints.nvim",
      branch = "anticonceal",
      config = function() require  "plugins.inlay-hints" end,
    },

    {
      "simrat39/rust-tools.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
      },
    },

    {
      'rmagatti/goto-preview',
      config = function() require  "plugins.goto" end,
    },

    -- Debugging -----------------------------------------------

    "mfussenegger/nvim-dap",
    {
      "rcarriga/nvim-dap-ui",
      version = "v3.6.4",
      config = function()
        -- require("dapui").setup()
      end,
      dependencies = { "mfussenegger/nvim-dap" },
    },

    -- Treesitter ----------------------------------------------
    {
      "nvim-treesitter/nvim-treesitter",
      config = function() require  "plugins.treesitter" end,
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
    },

    -- Refactoring helpers -------------------------------------

    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    },

    -- AI ------------------------------------------------------
    "github/copilot.vim",
    {
      "jameshiew/nvim-magic",
      config = function()
        require("nvim-magic").setup {
          backends = {
            default = require("nvim-magic-openai").new {
              api_endpoint = "https://api.openai.com/v1/engines/code-davinci-002/completions",
            },
          },
        }
      end,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
    },

    -- Completion and Snippets ---------------------------------
    {
      "ms-jpq/coq_nvim",
      branch = "coq",
      -- commit = "5eddd31bf8a98d1b893b0101047d0bb31ed20c49",
      dependencies = {
        { "ms-jpq/coq.artifacts",  branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p" },
      },
      config = function()
        require("coq_3p") {
          { src = "copilot", short_name = "COP", accept_key = "<c-f>" }
        }
        vim.g.coq_settings = {
          auto_start = "shut-up",
          clients = {
            tree_sitter = { enabled = false },
            paths = { enabled = true, resolution = { "file" } },
            snippets = { enabled = true, warn = {} },
            tags = { enabled = false },
          },
          keymap = { recommended = true },
          display = {
            preview = { positions = { north = 4, south = nil, west = 2, east = 3 } },
          },
        }
      end,
    },

    -- Snippet rendering ---------------------------------------
    {
      "narutoxy/silicon.lua",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("silicon").setup {}
      end,
    },

    -- Ansible filetype matching
    "pearofducks/ansible-vim",

    -- Project Management --------------------------------------
    {
      "ahmedkhalf/project.nvim",
      keys = { "<leader>fp" },
      cmd = { "ProjectRoot" },
      event = "VimEnter",
      config = function()
        require("project_nvim").setup {
          manual_mode = false,
          ignore_lsp = { "null-ls" },
          show_hidden = true,
          detection_methods = { "lsp", "pattern" },
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
    },

    -- Sessions ------------------------------------------------

    {
      "Shatur/neovim-session-manager",
      event = "VimEnter",
      config = [[require("plugins.sessions")]],
    },

    -- Git -----------------------------------------------------
    {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      module = "gitsigns",
      config = [[require("plugins.gitsigns")]],
    },
    {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      module = "neogit",
    },

    -- Markdown ------------------------------------------------
    {
      "plasticboy/vim-markdown",
      dependencies = {
        "godlygeek/tabular",
        opt = true,
      },
      ft = "markdown",
    },

    -- Eww & Lisp
    "gpanders/nvim-parinfer",
    "elkowar/yuck.vim",

    -- Utilities -----------------------------------------------

    -- Extensive increment/decrement support
    {
      "monaqa/dial.nvim",
      config = function() require "plugins.dial" end,
      keys = { "<C-a>", "<C-x>" },
    },

    -- hmm... what was that mapped to?
    {
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
    },

    -- comments are nice
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },

    -- todo comments
    {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function() require "plugins.todo" end,
    },

    -- Marks
    {
      "chentoast/marks.nvim",
      config = function() require "plugins.marks" end,
    },

    {
      "cbochs/grapple.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function() require "plugins.grapple" end,
    },

    -- Zen -------------------------------
    {
      "folke/zen-mode.nvim",
      cmd = { "ZenMode" },
      config = function()
        require("zen-mode").setup {
          twilight = { enabled = false },
          gitsigns = { enabled = true },
          kitty = { enabled = true, font = "+4" },
        }
      end,
    },
    {
      "folke/twilight.nvim",
      cmd = { "Twilight" },
    },

    -- highlight my logs
    {
      "MTDL9/vim-log-highlighting",
      ft = "log",
    },

    -- undotree
    {
      "mbbill/undotree",
      cmd = { "UndotreeToggle" },
    },

    {
      "dstein64/vim-startuptime",
    },

    -- highlight colors
    {
      "norcalli/nvim-colorizer.lua",
      cmd = { "ColorizerToggle" },
      keys = { "<leader>tc" },
    },
}
