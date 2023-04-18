local map = vim.keymap.set
local tree_cb = require("nvim-tree.config").nvim_tree_callback
local u = require "pmizio.utils"

-- disable netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local size = 50

require("nvim-tree").setup {
  hijack_cursor = true,
  view = {
    side = "right",
    mappings = {
      custom_only = false,
      list = {
        {
          key = "A",
          action = "toggle split width",
          action_cb = function()
            u.resize_split_by(size, { add = vim.api.nvim_win_get_width(0) < size })
          end,
        },
        { key = "s", cb = tree_cb "vsplit" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    custom = {
      "^.git$",
    },
  },
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        chars = "hjkl",
      },
    },
  },
}

map("n", "<leader>nn", ":NvimTreeToggle<CR>")
map("n", "<leader>nf", ":NvimTreeFindFile<CR>")
