local M = {}

M.setup = {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = false,
        useLibraryCodeForTypes = false,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}

return M
