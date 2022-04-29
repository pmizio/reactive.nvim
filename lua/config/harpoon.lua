local map = vim.keymap.set
local ui = require "harpoon.ui"

require("harpoon").setup {}

map("n", "<leader>a", require("harpoon.mark").add_file)
map("n", "<leader>j", function()
  ui.nav_file(1)
end)
map("n", "<leader>k", function()
  ui.nav_file(2)
end)
map("n", "<leader>l", function()
  ui.nav_file(3)
end)
map("n", "<leader>h", function()
  ui.nav_file(4)
end)

vim.api.nvim_create_user_command("Harpoon", ui.toggle_quick_menu, { force = true })
