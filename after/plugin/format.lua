local lsp_format = require "lsp-format"
local null_ls = require "null-ls"
local mason_null_ls = require "mason-null-ls"

mason_null_ls.setup {
  ensure_installed = { "stylua", "prettierd", "rustfmt" },
  automatic_setup = false,
}

local js_ts_opts = {
  tab_width = 2,
  order = { "eslint", "null-ls" },
}

lsp_format.setup {
  typescript = js_ts_opts,
  typescriptreact = js_ts_opts,
  javascript = js_ts_opts,
  javascriptreact = js_ts_opts,
  lua = { tab_width = 2 },
  rust = { tab_width = 4 },
  go = { tab_width = 4 },
}

null_ls.setup {
  on_attach = lsp_format.on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
  },
}
