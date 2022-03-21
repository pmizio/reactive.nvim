local lsp_format = require "lsp-format"
local null_ls = require "null-ls"

local TS_ORDER = { "eslint", "null-ls" }

lsp_format.setup {
  typescript = { tab_width = 2, order = TS_ORDER },
  typescriptreact = { tab_width = 2, order = TS_ORDER },
  javascript = { tab_width = 2, order = TS_ORDER },
  javascriptreact = { tab_width = 2, order = TS_ORDER },
  lua = { tab_width = 2 },
  rust = { tab_width = 4 },
}

null_ls.setup {
  on_attach = lsp_format.on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rustfmt,
  },
}
