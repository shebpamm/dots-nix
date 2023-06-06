return {
  "ms-jpq/chadtree",
  branch = "chad",
  keys = { "<C-n>" },
  cmd = "CHADopen",
  config = function()
    local chadtree_settings = {
      theme = {
        text_colour_set = "nord",
        icon_colour_set = "none",
      },
      options = {
        close_on_open = true,
      },
    }

    vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

    utils.nnoremap("<C-n>", "<CMD>CHADopen<CR>")
  end,
}
