local au = require "au"

au({ "BufNewFile", "BufRead" }, {
  "*",
  function()
    local header = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if header == "---" then
      vim.bo.filetype = "yaml"
    end
  end,
})
