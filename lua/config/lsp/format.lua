local lsp_format = require "lsp-format"
local null_ls = require "null-ls"
local utils = require "config.lsp.utils"

local JS_TS_SETTINGS = {
  tab_width = 2,
  order = { "eslint", "null-ls" },
  -- disable prettier formatting when prettier is not present @ project
  exclude = utils.has_prettier_config() and {} or { "null-ls" },
}

lsp_format.setup {
  typescript = JS_TS_SETTINGS,
  typescriptreact = JS_TS_SETTINGS,
  javascript = JS_TS_SETTINGS,
  javascriptreact = JS_TS_SETTINGS,
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
