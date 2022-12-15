-- Register autocommands to fix TMUX cursor
utils.augroup("tmux-cursor", {
  {
    events = { "VimLeave,VimSuspend" },
    targets = { "*" },
    command = "set guicursor=a:hor25"
  },
})
