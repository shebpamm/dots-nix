return {
  "rmagatti/goto-preview",
  keys = {
    { "gpd", function() require("goto-preview").goto_preview_definition() end,      desc = "preview definition" },
    { "gpD", function() require("goto-preview").goto_preview_type_definition() end, desc = "preview type definition" },
    { "gpi", function() require("goto-preview").goto_preview_implementation() end,  desc = "preview implementation" },
    { "gpr", function() require("goto-preview").goto_preview_references() end,      desc = "preview references" },
    { "gd",  vim.lsp.buf.definition,                                                desc = "definition" },
    { "gD",  vim.lsp.buf.type_definition,                                           desc = "type definition" },
    { "gi",  vim.lsp.buf.implementation,                                            desc = "implementation" },

  },
  opts = {
    preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
  }
}
