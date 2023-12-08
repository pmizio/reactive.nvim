return {
  dir = "~/Documents/GitHub/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local lsp = require "pmizio.lsp"
    local utils = require "pmizio.utils"

    local ok, tst = pcall(require, "typescript-tools")

    if not ok or utils.is_npm_installed "vue" then
      return
    end

    tst.setup {
      handlers = lsp.handlers,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        lsp.on_attach(client, bufnr)
      end,
      settings = {
        separate_diagnostic_server = true,
        composite_mode = "separate_diagnostic",
        publish_diagnostic_on = "insert_leave",
        -- tsserver_logs = "verbose",
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
      },
    }
  end,
}
