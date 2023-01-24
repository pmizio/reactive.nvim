local map = vim.keymap.set

require("toggleterm").setup {
  open_mapping = "<leader>tj",
}

map("n", "<leader>tx", ':TermExec cmd="TODO"<CR>')
