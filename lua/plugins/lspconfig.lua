return {
  "neovim/nvim-lspconfig",
  dependencies = { "j-hui/fidget.nvim", "folke/neodev.nvim" },
  event = "BufReadPre",
  config = function()
    local on_attach = require "pmizio.on_attach"

    require("neodev").setup {}

    local group = vim.api.nvim_create_augroup("LspConfig", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)

        if not client then
          return
        end

        on_attach(client, e.buf)
      end,
      group = group,
    })

    require("fidget").setup {
      text = { spinner = "moon" },
    }
  end,
}
