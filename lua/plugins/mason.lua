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
    local lsp = require "pmizio.lsp"

    require("mason").setup {}

    mason_lspconfig.setup {
      ensure_installed = { "lua_ls", "rust_analyzer", "eslint", "stylelint_lsp" },
    }

    tool_installer.setup {
      ensure_installed = {
        -- Linters
        "luacheck",
        -- Formatters
        "prettierd",
        "stylua",
      },
    }

    tool_installer.run_on_start()

    for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
      local serverConfig = require("lspconfig")[server]
      local setupObject = {
        handlers = lsp.handlers,

        on_attach = function(client, bufnr)
          lsp.on_attach(client, bufnr)

          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end
        end,
      }

      if serverConfig.name == "stylelint_lsp" then
        setupObject.filetypes =
          { "postcss", unpack(serverConfig.document_config.default_config.filetypes or {}) }
      end

      serverConfig.setup(setupObject)
    end
  end,
}
