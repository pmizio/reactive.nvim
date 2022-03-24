local tree_cb = require("nvim-tree.config").nvim_tree_callback
local u = require "config.utils"

local SIZE = 50

require("nvim-tree").setup {
  update_cwd = true,
  view = {
    mappings = {
      custom_only = false,
      list = {
        {
          key = "A",
          action = "toggle split width",
          action_cb = function()
            u.resize_split_by(SIZE, { add = vim.fn.winwidth "%" < SIZE })
          end,
        },
        { key = "s", cb = tree_cb "vsplit" },
      },
    },
  },
}

vim.keymap.set("n", "<leader>nn", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true })
