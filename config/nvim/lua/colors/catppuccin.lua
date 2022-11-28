local M = {}
local cmd = vim.cmd
local ct = require "catppuccin"
local palettes = require "catppuccin.palettes"

local flavour = "frappe" -- latte, frappe, macchiato, mocha

function M.setup()
  ct.setup {
    flavour = flavour,
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15,
    },
    integrations = {
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
  }

  cmd "colorscheme catppuccin"
end

local cc = palettes.get_palette(flavour)

M.colors = {
  fg = cc.text,
  bg = cc.base,
  accent = cc.green,
  lightbg = cc.mantle,
  fgfaded = cc.lavender,
  grey = cc.surface1,
  light_grey = cc.surface2,
  dark_grey = cc.surface0,
  bright = cc.pink,
  red = cc.red,
  green = cc.green,
  blue = cc.blue,
  yellow = cc.yellow,
  magenta = cc.maroon,
  orange = cc.peach,
  cyan = cc.teal,
  ViMode = {
    Normal = cc.green,
  },
}
-- rosewater	#dc8a78	#F2D5CF	#F4DBD6	#F5E0DC	Winbar
-- flamingo	#DD7878	#EEBEBE	#F0C6C6	#F2CDCD	Target word
-- pink	        #ea76cb	#F4B8E4	#F5BDE6	#F5C2E7	Just pink
-- mauve	#8839EF	#CA9EE6	#C6A0F6	#CBA6F7	Tag
-- red	        #D20F39	#E78284	#ED8796	#F38BA8	Error
-- maroon	#E64553	#EA999C	#EE99A0	#EBA0AC	Lighter red
-- peach	#FE640B	#EF9F76	#F5A97F	#FAB387	Number
-- yellow	#df8e1d	#E5C890	#EED49F	#F9E2AF	Warning
-- green	#40A02B	#A6D189	#A6DA95	#A6E3A1	Diff add
-- teal	        #179299	#81C8BE	#8BD5CA	#94E2D5	Hint
-- sky	        #04A5E5	#99D1DB	#91D7E3	#89DCEB	Operator
-- sapphire	#209FB5	#85C1DC	#7DC4E4	#74C7EC	Constructor
-- blue	        #1e66f5	#8CAAEE	#8AADF4	#89B4FA	Diff changed
-- lavender	#7287FD	#BABBF1	#B7BDF8	#B4BEFE	CursorLine Nr
-- text	        #4C4F69	#c6d0f5	#CAD3F5	#CDD6F4	Default fg
-- subtext1	#5C5F77	#b5bfe2	#B8C0E0	#BAC2DE	Indicator
-- subtext0	#6C6F85	#a5adce	#A5ADCB	#A6ADC8	Float title
-- overlay2	#7C7F93	#949cbb	#939AB7	#9399B2	Popup fg
-- overlay1	#8C8FA1	#838ba7	#8087A2	#7F849C	Conceal color
-- overlay0	#9CA0B0	#737994	#6E738D	#6C7086	Fold color
-- surface2	#ACB0BE	#626880	#5B6078	#585B70	Default comment
-- surface1	#BCC0CC	#51576d	#494D64	#45475A	Darker comment
-- surface0	#CCD0DA	#414559	#363A4F	#313244	Darkest comment
-- base	        #EFF1F5	#303446	#24273A	#1E1E2E	Default bg
-- mantle	#E6E9EF	#292C3C	#1E2030	#181825	Darker bg
-- crust	#DCE0E8	#232634	#181926	#11111B	Darkest bg

function M.overrides()
  vim.cmd [[
    hi TabLineSel guifg=#d8dee9 guibg=#5C5F77 gui=italic
    hi LspReferenceText guibg=#3a404c gui=NONE
    hi LspReferenceWrite guibg=#3a404c gui=NONE
    hi LspReferenceRead guibg=#3a404c gui=NONE
    hi MatchParen guibg=#3a404c
    hi IndentBLanklineContextChar guifg=#61afef
  ]]
end

return M
