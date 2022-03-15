local prettier = {
  formatCommand = [[prettierd "${INPUT}"]],
  formatStdin = true,
}

local stylua = {
  formatCommand = [[stylua -]],
  formatStdin = true,
}

local rustfmt = {
  formatCommand = [[rustfmt --emit=stdout --edition=2021]],
  formatStdin = true,
}

require("lsp-format").setup {
  typescript = { tab_width = 2 },
  typescriptreact = { tab_width = 2 },
  javascript = { tab_width = 2 },
  javascriptreact = { tab_width = 2 },
  lua = { tab_width = 2 },
  rust = { tab_width = 4 },
}

require("nvim-lsp-installer").on_server_ready(function(server)
  if server.name == "efm" then
    server:setup {
      on_attach = require("lsp-format").on_attach,
      init_options = { documentFormatting = true },
      settings = {
        languages = {
          typescript = { prettier },
          typescriptreact = { prettier },
          javascript = { prettier },
          javascriptreact = { prettier },
          lua = { stylua },
          rust = { rustfmt },
        },
      },
    }
  end
end)
