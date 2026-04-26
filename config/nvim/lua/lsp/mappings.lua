local wk = require "which-key"

local function hover()
  vim.lsp.buf.hover { border = "single" }
end

local function signature_help()
  vim.lsp.buf.signature_help { border = O.borders }
end

wk.register {
  ["<leader>"] = {
    c = {
      name = "+code",
      r = { vim.lsp.buf.rename, "rename" },
      a = {
        function()
          require("fastaction").code_action()
        end,
        "code action",
      },
    },
    l = {
      name = "+lsp",
      i = { "<cmd>LspInfo<cr>", "Lsp Info" },
      a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
      r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
      l = { vim.lsp.buf.list_workspace_folders, "List Folders" },
    },
  },
  g = {
    name = "+goto",
    d = { vim.lsp.buf.definition, "definition" },
    D = { vim.lsp.buf.type_definition, "type definition" },
    i = { vim.lsp.buf.implementation, "implementation" },
    r = { vim.lsp.buf.references, "references" },
  },
  ["]d"] = { vim.diagnostic.goto_next, "next diagnostic" },
  ["[d"] = { vim.diagnostic.goto_prev, "prev diagnostic" },
  ["<C-k>"] = { signature_help, "signature help" },
  K = { hover, "lsp: hover" },
}

-- Visual mode mappings
wk.register {
  c = {
    name = "+code",
    a = { vim.lsp.buf.code_action, "range code action" },
  },
}
