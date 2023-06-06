require("colors." .. O.colorscheme).setup()
local c = require("colors." .. O.colorscheme).colors

local cmd = vim.cmd
cmd("hi StatusLineAccent guifg=" .. c.bg .. " guibg=" .. c.accent or c.magenta)
cmd("hi StatusLineInsertAccent guifg=" .. c.bg .. " guibg=" .. c.red)
cmd("hi StatusLineVisualAccent guifg=" .. c.bg .. " guibg=" .. c.green)
cmd("hi StatusLineReplaceAccent guifg=" .. c.bg .. " guibg=" .. c.red)
cmd("hi StatusLineCmdLineAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatuslineTerminalAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatusLineExtra guifg=" .. c.fgfaded)
cmd "hi StatusLineNC guibg=NONE"

cmd "hi qfLineNr ctermfg=NONE cterm=bold guifg=NONE gui=bold"
cmd "hi QuickFixLine ctermfg=NONE cterm=bold guifg=NONE gui=bold"

cmd("hi CursorLineNr guibg=" .. c.lightbg)

-- Inlay hints
cmd "hi link LspInlayHint Comment"

-- On-hover highlighting of references
cmd "hi LspReferenceText cterm=bold gui=bold"
cmd "hi LspReferenceRead cterm=bold gui=bold"
cmd "hi LspReferenceWrite cterm=bold gui=bold"


require("colors." .. O.colorscheme).overrides()
