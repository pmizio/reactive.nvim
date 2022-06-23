require("true-zen").setup {
  modes = {
    focus = {
      margin_of_error = 5,
      focus_method = "experimental",
    },
  },
  integrations = {
    gitsigns = true,
    lualine = true,
  },
  misc = {
    on_off_commands = false,
  },
}

vim.keymap.set("n", "<leader>m", ":TZFocus<CR>", { noremap = true, silent = true })
