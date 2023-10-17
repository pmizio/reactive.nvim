return {
  dir = "~/Documents/GitHub/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local on_attach = require "pmizio.on_attach"
    local utils = require "pmizio.utils"

    local ok, tst = pcall(require, "typescript-tools")

    if not ok or utils.is_npm_installed "vue" then
      return
    end

    tst.setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end,
      settings = {
        separate_diagnostic_server = true,
        composite_mode = "separate_diagnostic",
        publish_diagnostic_on = "insert_leave",
      },
    }
  end,
}
