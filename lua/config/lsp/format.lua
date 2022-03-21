local lsp_format = require "lsp-format"
local null_ls = require "null-ls"

local js_ts_order = { "eslint", "null-ls" }

lsp_format.setup {
  typescript = { tab_width = 2, order = js_ts_order },
  typescriptreact = { tab_width = 2, order = js_ts_order },
  javascript = { tab_width = 2, order = js_ts_order },
  javascriptreact = { tab_width = 2, order = js_ts_order },
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

-- require("nvim-lsp-installer").on_server_ready(function(server)
--   if server.name == "efm" then
--     server:setup {
--       on_attach = require("lsp-format").on_attach,
--       init_options = { documentFormatting = true },
--       settings = {
--         languages = {
--           typescript = { prettier },
--           typescriptreact = { prettier },
--           javascript = { prettier },
--           javascriptreact = { prettier },
--           lua = { stylua },
--           rust = { rustfmt },
--         },
--       },
--     }
--   end
-- end)
