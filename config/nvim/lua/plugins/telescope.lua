return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  config = function()
    local telescope = require "telescope"
    local a = require "telescope.actions"
    local b = require "telescope.builtin"
    local x = telescope.extensions
    local l = telescope.load_extension

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<c-c>"] = function()
              vim.cmd "stopinsert!"
            end,
            ["<esc>"] = a.close,
            ["<c-s>"] = a.select_horizontal,
            ["<c-j>"] = a.cycle_history_next,
            ["<c-k>"] = a.cycle_history_prev,
          },
        },
        file_ignore_patterns = {
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.otf",
          "%.ttf",
          "node_modules",
          ".git",
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
        -- winblend = 30,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        extensions = {
          -- frecency = {
          --   workspaces = {
          --     dotfiles = "$HOME/dotfiles",
          --     projects = "$HOME/projects",
          --     dwm = "$HOME/projects/dwm",
          --     site = "$HOME/projects/site",
          --   },
          -- },
          fzf = {
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
          },
        },
      },
    }

    l "fzf"
    l "projects"
    l "file_browser"
    l "live_grep_args"

    local function grep()
      x.live_grep_args.live_grep_args {
        path_display = { "shorten" },
        only_sort_text = true,
        use_regex = true,
      }
    end

    local function grep_open_files()
      b.live_grep {
        grep_open_files = true,
        path_display = { "shorten" },
      }
    end

    local function ivy()
      vim.cmd [[ set laststatus=0 ]]
      b.find_files {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 8,
        },
        border = true,
        borderchars = {
          "z",
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
        },
      }
      vim.cmd [[ set laststatus=2 ]]
    end

    local function browse_files()
      vim.cmd [[ set laststatus=0 ]]
      x.file_browser.file_browser {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 10,
        },
        border = true,
        borderchars = { "" },
      }
      vim.cmd [[ set laststatus=2 ]]
    end

    local function buffers()
      vim.cmd [[ set laststatus=0 ]]
      b.buffers {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 7,
        },
        border = true,
        borderchars = {
          "z",
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
        },
      }
      vim.cmd [[ set laststatus=2 ]]
    end

    local function lsp_code_actions()
      b.lsp_code_actions {
        sorting_strategy = "ascending",
        results_title = false,
        layout_strategy = "cursor",
        layout_config = {
          width = 70,
          height = 10,
        },
        borderchars = {
          prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
          preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
      }
    end

    local wk = require "which-key"

    wk.register {
      ["<leader>"] = {
        -- find
        f = {
          name = "+find",
          f = { b.find_files, "files" },
          -- r = { x.frecency.frecency, "frecent files" },
          w = { grep, "grep" },
          o = { grep_open_files, "grep open files" },
          b = { b.current_buffer_fuzzy_find, "find in buffer" },
          m = { b.man_pages, "man pages" },
          h = { b.help_tags, "help" },
          i = { ivy, "ivy" },
          p = { x.projects.projects, "projects" },
          t = { "<cmd>TodoTelescope<cr>", "todos" },
          g = {
            name = "+git",
            f = { b.git_files, "files" },
            b = { b.git_branches, "branches" },
            c = { b.git_commits, "commits" },
            s = { b.git_status, "status" },
            S = { b.git_stash, "stash" },
          },
          l = {
            name = "+lsp",
            d = { b.lsp_definitions, "definitions" },
            r = { b.lsp_references, "references" },
            i = { b.lsp_implementations, "implementations" },
            s = { b.lsp_document_symbols, "document symbols" },
            w = { b.lsp_workspace_symbols, "workspace symbols" },
          },
        },
      },
      ["<M-f>"] = { ivy, "find files" },
      ["<M-b>"] = { browse_files, "browse files" },
      ["<M-s>"] = { buffers, "switch buffer" },
    }

    return { lsp_code_actions = lsp_code_actions }
  end,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-live-grep-raw.nvim" },
  },
}
