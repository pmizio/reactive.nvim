local tree_cb = require("nvim-tree.config").nvim_tree_callback

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
            if vim.fn.winwidth "%" < SIZE then
              vim.cmd("vertical resize +" .. SIZE)
            else
              vim.cmd("vertical resize -" .. SIZE)
            end
          end,
        },
        { key = "s", cb = tree_cb "vsplit" },
      },
    },
  },
}
