return {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  keys = {
    { "<C-p>", ":Telescope find_files path_display={'shorten'}<CR>" },
    { "<C-f>", ":Telescope live_grep only_sort_text=true<CR>" },
    { "<leader>b", ":Telescope buffers<CR>" },
  },
  config = function()
    local actions = require "telescope.actions"
    local telescope = require "telescope"

    telescope.setup {
      defaults = {
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<Up>"] = false,
            ["<Down>"] = false,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            ["<leader>q"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<ESC>"] = actions.close,
          },
        },
        path_display = { "shorten", "tail" },
        layout_config = {
          prompt_position = "top",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }

    telescope.load_extension "fzf"
  end,
}
