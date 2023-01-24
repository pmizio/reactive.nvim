local map = vim.keymap.set
local tree_cb = require("nvim-tree.config").nvim_tree_callback
local u = require "pmizio.utils"

-- disable netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local SIZE = 50

require("nvim-tree").setup {
  update_cwd = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
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
  renderer = {
    full_name = true,
    group_empty = true,
    special_files = {},
    symlink_destination = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = { "help" },
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
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
    open_file = {
      resize_window = true,
      window_picker = {
        chars = "asdf",
      },
    },
    remove_file = {
      close_window = false,
    },
  },
}

map("n", "<leader>nn", ":NvimTreeToggle<CR>")
map("n", "<leader>nf", ":NvimTreeFindFile<CR>")
