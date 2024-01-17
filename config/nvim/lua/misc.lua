-- Register autocommands to fix TMUX cursor
utils.augroup("tmux-cursor", {
  {
    events = { "VimLeave,VimSuspend" },
    targets = { "*" },
    command = "set guicursor=a:hor25"
  },
})

-- Open VS Code at the cursor
local function open_vscode()
  local line = vim.fn.line(".")
  local column = vim.fn.col(".")
  local file = vim.fn.expand("%:p")
  local command = string.format("code --goto '%s:%s:%s'", file, line, column)
  vim.fn.system(command)
end

utils.command("VSCode", open_vscode)
utils.nnoremap("<M-v>", ":VSCode<CR>")

-- Center screen after up-down movement
utils.nnoremap("<C-d>", "<C-d>zz")
utils.nnoremap("<C-u>", "<C-u>zz")
