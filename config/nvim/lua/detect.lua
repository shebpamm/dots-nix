vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*" },
  callback = function()
    local header = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if header == "---" then
      if vim.bo.filetype ~= "yaml.ansible" then
        if vim.fn.search('{{.\\+}}', 'nw') ~= 0 then
          vim.bo.filetype = "gotmpl"
        end
      end
    end
  end,
})
