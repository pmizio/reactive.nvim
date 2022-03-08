local ui = require "harpoon.ui"

require("harpoon").setup {}

vim.keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end)
vim.keymap.set("n", "<leader>j", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>k", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>l", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>h", function()
  ui.nav_file(4)
end)

vim.cmd "command! Harpoon lua require('harpoon.ui').toggle_quick_menu()"
