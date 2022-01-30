local m = require "mapx"

require("harpoon").setup {}

m.nnoremap("<leader>a", "<cmd>lua require'harpoon.mark'.add_file()<CR>", "silent")
m.nnoremap("<leader>j", "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", "silent")
m.nnoremap("<leader>k", "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", "silent")
m.nnoremap("<leader>l", "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", "silent")
m.nnoremap("<leader>h", "<cmd>lua require'harpoon.ui'.nav_file(4)<CR>", "silent")

vim.cmd "command! Harpoon lua require('harpoon.ui').toggle_quick_menu()"
