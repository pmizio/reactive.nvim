return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = "BufReadPre",
  cmd = "Mason",
  config = function()
    local mason_lspconfig = require "mason-lspconfig"
    local tool_installer = require "mason-tool-installer"
    local on_attach = require "pmizio.on_attach"

    require("mason").setup {}

    mason_lspconfig.setup {
      ensure_installed = { "lua_ls", "rust_analyzer", "eslint" },
    }

    tool_installer.setup {
      ensure_installed = {
        -- Linters
        "luacheck",
        "eslint_d",
        -- Formatters
        "prettierd",
        "stylua",
      },
    }

    tool_installer.run_on_start()

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      }),
    }

    for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
      require("lspconfig")[server].setup {
        on_attach = on_attach,
        handlers = handlers,
      }
    end
  end,
}
