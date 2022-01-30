local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup {
  update_cwd = true,
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = { "A" }, cb = ":call ToggleTreeWidth(50)<CR>" },
        { key = { "<CR>" }, cb = tree_cb "edit" },
        { key = { "s" }, cb = tree_cb "vsplit" },
      },
    },
  },
}
