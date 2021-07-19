local M = {}

if O.lang.rust.rust_tools.enabled then
  M.rust_tools_setup = function(on_attach)
    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = " <-",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
        },
        hover_actions = {
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
        },
      },
      server = {
        cmd = { vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer" },
        on_attach = on_attach,
      },
    })
  end
end

M.setup = function(on_attach)
  require("lspconfig").rust_analyzer.setup({
    cmd = { vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer" },
    on_attach = on_attach,
  })
end
return M
