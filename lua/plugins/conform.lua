local formatters_by_ft = {
  lua = { "stylua" },
}

local eslint_ft = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
}

for _, ft in ipairs(eslint_ft) do
  formatters_by_ft[ft] = { "eslint_d", "prettierd" }
end

local prettier_ft = {
  "html",
  "css",
  "postcsss",
  "markdown",
  "json",
  "yaml",
}

for _, ft in ipairs(prettier_ft) do
  formatters_by_ft[ft] = { "prettierd" }
end

return {
  "stevearc/conform.nvim",
  ft = vim.tbl_keys(formatters_by_ft),
  config = function()
    local conform = require "conform"

    conform.setup {
      formatters_by_ft = formatters_by_ft,
    }

    local group = vim.api.nvim_create_augroup("Conform", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(e)
        conform.format {
          bufnr = e.buf,
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,
      group = group,
    })
  end,
}
