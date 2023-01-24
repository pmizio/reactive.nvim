local map = vim.keymap.set
local actions = require "telescope.actions"
local telescope = require "telescope"
local builtin = require "telescope.builtin"

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
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

map("n", "<C-p>", function()
  builtin.find_files { path_display = { "shorten" } }
end)
map("n", "<C-f>", function()
  builtin.live_grep { only_sort_text = true }
end)
map("n", "<leader>b", builtin.buffers)
map("n", "<C-g>", builtin.git_branches)
map("n", "<leader>p", function()
  telescope.extensions.project.project {}
end)
