local ui = require "harpoon.ui"
local m = require "config.utils.map"

require("harpoon").setup {}

m.nmap("<leader>a", require("harpoon.mark").add_file)
m.nmap("<leader>j", function()
  ui.nav_file(1)
end)
m.nmap("<leader>k", function()
  ui.nav_file(2)
end)
m.nmap("<leader>l", function()
  ui.nav_file(3)
end)
m.nmap("<leader>h", function()
  ui.nav_file(4)
end)

vim.api.nvim_create_user_command("Harpoon", ui.toggle_quick_menu, { force = true })
