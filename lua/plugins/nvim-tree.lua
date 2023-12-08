return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>nn", ":NvimTreeToggle<CR>" },
    { "<leader>nf", ":NvimTreeFindFile<CR>" },
  },
  config = function()
    local map = vim.keymap.set
    local api = require "nvim-tree.api"
    local u = require "pmizio.utils"

    local size = 50

    require("nvim-tree").setup {
      hijack_cursor = true,
      disable_netrw = true,
      view = {
        side = "right",
      },
      renderer = {
        indent_markers = { enable = true },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      filters = {
        custom = { "^.git$" },
      },
      actions = {
        open_file = {
          window_picker = { chars = "hjkl" },
        },
      },
      on_attach = function(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        local opts = { buffer = bufnr, silent = true, nowait = true }

        map("n", "s", api.node.open.vertical, opts)
        map("n", "A", function()
          u.resize_split_by(size, { add = vim.api.nvim_win_get_width(0) < size })
        end, opts)
      end,
    }
  end,
}
