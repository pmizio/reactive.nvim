local linters_by_ft = {
  lua = { "luacheck" },
}

return {
  "mfussenegger/nvim-lint",
  ft = vim.tbl_keys(linters_by_ft),
  config = function()
    local lint = require "lint"
    local utils = require "pmizio.utils"

    lint.linters_by_ft = linters_by_ft

    utils.config_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      pattern = "*",
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
