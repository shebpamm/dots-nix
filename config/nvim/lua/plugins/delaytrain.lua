return {
  "ja-ford/delaytrain.nvim",
  init = function()
    require('delaytrain').setup {
      delay_ms = 800,
      grace_period = 1,
    }
  end,
}
