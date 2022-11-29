local coke = require "cokeline"
local coke_utils = require "cokeline.utils"
local hex = coke_utils.get_hex

coke.setup {
  show_if_buffers_are_at_least = 2,

  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and hex('TabLineSel', 'fg')
         or hex('TabLineFill', 'fg')
    end,
    bg = function(buffer)
      return
        buffer.is_focused
        and hex('TabLineSel', 'bg')
         or hex('TabLineFill', 'bg')
    end,
  },

  components = {
    {
      text = function(buffer) return ' ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.unique_prefix end,
      fg = hex('Directory', 'fg'),
      style = 'italic',
    },
    {
      text = function(buffer) return buffer.filename .. ' ' end,
    },
  },
}

-- Go to buffer at index i
for i = 1, 9 do
  utils.nnoremap("<M-" .. i .. ">", "<Plug>(cokeline-focus-" .. i ..")")
end

-- Swap active with index i
for i = 1, 9 do
  utils.nnoremap("<M-S-" .. i .. ">", "<Plug>(cokeline-switch-" .. i ..")")
end

-- Close buffer
utils.nnoremap("<M-d>", ":bd<Cr>")

-- Prev buffer
utils.nnoremap("<M-j>", "<Plug>(cokeline-focus-prev)")

-- Next buffer
utils.nnoremap("<M-k>", "<Plug>(cokeline-focus-next)")

-- Switch with prev
utils.nnoremap("<M-h>", "<Plug>(cokeline-switch-prev)")

-- Switch with next
utils.nnoremap("<M-l>", "<Plug>(cokeline-switch-next)")

-- Focus by pick_letter
utils.nnoremap("<M-p>", "<Plug>(cokeline-pick-focus)")
