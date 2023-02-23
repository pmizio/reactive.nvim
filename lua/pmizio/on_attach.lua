local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

local function on_attach(client, bufnr)
  client.server_capabilities.documentRangeFormattingProvider = false

  local function lsp_map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  lsp_map("n", "gd", vim.lsp.buf.declaration)
  lsp_map("n", "K", function()
    builtin.lsp_definitions(themes.get_ivy())
  end)
  lsp_map("n", "gk", function()
    builtin.lsp_definitions(themes.get_ivy { jump_type = "vsplit" })
  end)
  lsp_map("n", "gh", vim.lsp.buf.hover)
  lsp_map("n", "gi", vim.lsp.buf.implementation)
  lsp_map("n", "<leader>D", vim.lsp.buf.type_definition)
  lsp_map("n", "<leader>rr", vim.lsp.buf.rename)
  lsp_map({ "n", "x", "v" }, "<leader>ca", vim.lsp.buf.code_action)
  lsp_map("n", "gr", function()
    builtin.lsp_references(themes.get_ivy())
  end)
  lsp_map("n", "[d", vim.diagnostic.goto_prev)
  lsp_map("n", "]d", vim.diagnostic.goto_next)
  lsp_map("n", "<C-E>", vim.diagnostic.open_float)
  lsp_map("i", "<C-K>", vim.lsp.buf.signature_help)
end

return on_attach
