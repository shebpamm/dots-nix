return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup {
      suggestion = {
        enabled = true;
        hide_during_completion = false;
        auto_trigger = true;
        keymap = {
          accept = "<C-f>",
          prev = "<C-j>",
          next = "<C-l>",
        },
      },
    }
  end,
}
