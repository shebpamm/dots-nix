local utils = require "utils"
local map = utils.map
local wk = require "which-key"

map("n", "<leader>n", [[ <Cmd> set nu!<CR> ]])
map("n", "<leader>nr", [[ <Cmd> set relativenumber!<CR> ]])
map("n", "<leader>s", [[ <Cmd> set spell!<CR> ]])

map("n", "<leader>,", [[ <Cmd>edit ~/.config/nvim/lua/config.lua<CR>]])

-- packer commands
map("n", "<leader>pu", [[ <Cmd> PackerUpdate<CR>]])
map("n", "<leader>ps", [[ <Cmd> PackerSync<CR>]])
map("n", "<leader>pc", [[ <Cmd> PackerCompile<CR>]])
map("n", "<leader>pi", [[ <Cmd> PackerInstall<CR>]])

-- clear search highlight on enter
map("n", "<CR>", [[ <Cmd> nohl<CR>]])

-- easily switch tabs
for i = 1, 9 do
  map(
    "n",
    "<A-" .. i .. ">",
    ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>"
  )
  wk.register {
    ["<A-" .. i .. ">"] = "switch to buffer " .. i,
  }
end
