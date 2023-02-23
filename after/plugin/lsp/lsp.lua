local on_attach = require "pmizio.on_attach"

local lsp = require("lsp-zero").preset {
  name = "lsp-compe",
  set_lsp_keymaps = {
    preserve_mappings = false,
  },
}

lsp.nvim_workspace()

lsp.ensure_installed { "sumneko_lua", "eslint", "jsonls", "clangd", "rust_analyzer" }

lsp.on_attach(on_attach)

lsp.configure("eslint", {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.renameProvider = false
    require("lsp-format").on_attach(client)
  end,
})

local rust_lsp = lsp.build_options("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})

lsp.setup()

require("rust-tools").setup { server = rust_lsp }

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
      if code and not string.find(t.message, code, 1, true) then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}
