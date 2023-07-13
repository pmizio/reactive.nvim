require("eyeliner").setup {
  highlight_on_key = true,
  match = "[%w]",
}

vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ff0000", underline = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#5fffff", underline = true })
