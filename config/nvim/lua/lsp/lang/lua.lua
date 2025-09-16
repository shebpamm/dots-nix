local M = {}

M.setup = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = {
          'vim',
          "O",
          "utils",

          -- awesomewm stuff
          "awesome",
          "client",
          "screen",
        }
      },
    },
  },
}

return M
