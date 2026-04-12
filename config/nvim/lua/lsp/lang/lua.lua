local M = {}

M.setup = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { -- this contains a bunch of symlinks to nix store
        ignoreDir = {
          "roots",
          "**/roots/**",
        },
      },
      diagnostics = {
        globals = {
          "vim",
          "O",
          "utils",

          -- awesomewm stuff
          "awesome",
          "client",
          "screen",
        },
      },
    },
  },
}

return M
