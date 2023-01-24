local actions = require "telescope.actions"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local m = require "config.utils.map"

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
telescope.load_extension "git_worktree"
telescope.load_extension "project"

m.nmap("<C-p>", function()
  builtin.find_files { path_display = { "shorten" } }
end)
m.nmap("<C-f>", function()
  builtin.live_grep { only_sort_text = true, file_igonre_patterns = { "package-lock.json" } }
end)
m.nmap("<leader>b", builtin.buffers)
m.nmap("<C-g>", builtin.git_branches)
m.nmap("<leader>w", telescope.extensions.git_worktree.git_worktrees)
m.nmap("<leader>p", function()
  telescope.extensions.project.project {}
end)
