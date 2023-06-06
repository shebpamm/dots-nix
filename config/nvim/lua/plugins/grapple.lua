return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local gr = require "grapple"
    local wk = require "which-key"

    gr.setup {
      log_level = "warn",
      scope = gr.resolvers.git,
      popup_options = {
        relative = "editor",
        width = 60,
        height = 12,
        style = "minimal",
        focusable = false,
        border = "single",
      },
    }

    local function qf()
      if utils.is_open "c" then
        vim.cmd "cclose"
      else
        gr.quickfix()
      end
    end

    wk.register {
      ["<leader>"] = {
        r = {
          name = "+grapple",
          q = { qf, "quickfix" },
          t = { gr.popup_tags, "show tags" },
          s = { gr.popup_scopes, "show scopes" },
          d = { gr.untag, "untag" },
          a = { gr.tag, "tag" },
        },
      },
    }
  end,
}
