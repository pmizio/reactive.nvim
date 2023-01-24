local lsp = require "lsp-zero"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

lsp.preset "lsp-compe"
lsp.nvim_workspace()

lsp.ensure_installed { "sumneko_lua", "eslint", "jsonls" }

lsp.on_attach(function(client, bufnr)
  client.server_capabilities.documentRangeFormattingProvider = false

  local function lsp_map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  lsp_map("n", "gd", vim.lsp.buf.declaration)
  lsp_map("n", "K", function()
    builtin.lsp_definitions(themes.get_ivy())
  end)
  lsp_map("n", "gK", function()
    builtin.lsp_definitions(themes.get_ivy { jump_type = "vsplit" })
  end)
  lsp_map("n", "gh", vim.lsp.buf.hover)
  lsp_map("n", "gi", vim.lsp.buf.implementation)
  lsp_map("n", "<leader>D", vim.lsp.buf.type_definition)
  lsp_map("n", "<leader>rr", vim.lsp.buf.rename)
  lsp_map("n", "<leader>ca", vim.lsp.buf.code_action)
  lsp_map("n", "gr", function()
    builtin.lsp_references(themes.get_ivy())
  end)
  lsp_map("n", "[d", vim.diagnostic.goto_prev)
  lsp_map("n", "]d", vim.diagnostic.goto_next)
  lsp_map("v", "<leader>ca", vim.lsp.buf.code_action)
end)

lsp.configure("eslint", {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.renameProvider = false
    require("lsp-format").on_attach(client)
  end,
})

lsp.setup()

require("fidget").setup {
  text = { spinner = "moon" },
}

vim.diagnostic.config {
  underline = true,
  signs = true,
  virtual_text = true,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}
