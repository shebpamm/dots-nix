local chadtree_settings = {
  theme = {
    text_colour_set = "nord",
    icon_colour_set = "none"
  }
}

vim.api.nvim_set_var("chadtree_settings", chadtree_settings)


utils.nnoremap("<C-n>", "<CMD>CHADopen<CR>")
