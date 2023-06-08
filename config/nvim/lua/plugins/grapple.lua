local function qf()
  if utils.is_open "c" then
    vim.cmd "cclose"
  else
    require("grapple").quickfix()
  end
end

return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>rq", qf, desc = "grapple quickfix" },
    {
      "<leader>rt",
      function()
        require("grapple").popup_tags()
      end,
      desc = "show grapple tags",
    },
    {
      "<leader>rs",
      function()
        require("grapple").popup_scopes()
      end,
      desc = "show grapple scopes",
    },
    {
      "<leader>rd",
      function()
        require("grapple").untag()
      end,
      desc = "grapple untag",
    },
    {
      "<leader>ra",
      function()
        require("grapple").tag()
      end,
      desc = "grapple tag",
    },
  },
  config = function()
    local gr = require "grapple"

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
  end,
}
