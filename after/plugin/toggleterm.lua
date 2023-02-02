local map = vim.keymap.set

require("toggleterm").setup {
  open_mapping = "<leader>tj",
  persist_size = false,
  insert_mappings = false,
}

map("n", "<leader>tx", ':TermExec cmd="TODO"<CR>')
