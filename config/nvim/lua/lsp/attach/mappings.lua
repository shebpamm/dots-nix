local M = {}
local goto = require "goto-preview"

function M.setup(bufnr)
  local wk = require "which-key"
  local dap = require "dap"
  local dui = require "dapui"

  wk.register({
    c = {
      name = "+code",
      r = { vim.lsp.buf.rename, "rename" },
      a = { vim.lsp.buf.code_action, "code action" },
      d = {
        name = "+debug",
        b = { dap.toggle_breakpoint, "toggle breakpoint" },
        c = { dap.continue, "continue" },
        i = { dap.step_over, "step into" },
        o = { dap.step_over, "step over" },
        u = { dui.toggle(), "toggle ui" },
      },
    },
    g = {
      name = "+goto",
      d = { goto.goto_preview_definition, "definition" },
      D = { goto.goto_preview_type_definition, "type definition" },
      i = { goto.goto_preview_implementation, "implementation" },
      r = { goto.goto_preview_references, "references" },
    },
    K = { vim.lsp.buf.hover, "lsp: hover" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "signature help" },
    ["<leader>l"] = {
      name = "+lsp",
      i = { "<cmd>LspInfo<cr>", "Lsp Info" },
      a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
      r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
      l = { vim.lsp.buf.list_workspace_folders, "List Folders" },
    },
    ["]d"] = { vim.diagnostic.goto_next, "next diagnostic" },
    ["[d"] = { vim.diagnostic.goto_prev, "prev diagnostic" },
  }, {
    buffer = bufnr,
  })

  -- Visual mode mappings
  wk.register({
    c = {
      name = "+code",
      a = { vim.lsp.buf.range_code_action, "range code action" },
    },
  }, {
    buffer = bufnr,
    mode = "v",
  })
end

return M