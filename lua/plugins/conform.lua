local formatters_by_ft = {
  lua = { "stylua" },
}

local prettierd_ft = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
  "html",
  "css",
  "postcsss",
  "markdown",
  "json",
  "yaml",
}

for _, ft in ipairs(prettierd_ft) do
  formatters_by_ft[ft] = { "prettierd" }
end

return {
  "stevearc/conform.nvim",
  ft = vim.tbl_keys(formatters_by_ft),
  config = function()
    local conform = require "conform"
    local utils = require "pmizio.utils"

    conform.setup {
      formatters_by_ft = formatters_by_ft,
    }

    utils.config_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(e)
        local client = vim.lsp.get_clients({ buf = e.buf })[1]

        ---@diagnostic disable-next-line: undefined-field
        if client and client.name == "eslint" then
          vim.lsp.buf.format { async = false }
        end

        conform.format {
          bufnr = e.buf,
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,
    })
  end,
}
