-- Register autocommands to fix TMUX cursor
utils.augroup("tmux-cursor", {
  {
    events = { "VimLeave,VimSuspend" },
    targets = { "*" },
    command = "set guicursor=a:hor25"
  },
})

-- Center screen after up-down movement
utils.nnoremap("<C-d>", "<C-d>zz")
utils.nnoremap("<C-u>", "<C-u>zz")
