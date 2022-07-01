local m = require "config.utils.map"

vim.g.undotree_WindowLayout = 3

local function toggle()
  vim.api.nvim_command "UndotreeToggle"
  vim.api.nvim_command "UndotreeFocus"
end

m.nmap("<leader>h", toggle)
