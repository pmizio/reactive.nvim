local m = require "mapx"

local actions = require "telescope.actions"
local telescope = require "telescope"
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

m.nnoremap("<C-p>", "<cmd>lua require'telescope.builtin'.find_files{ path_display = { 'shorten' } }<CR>")
m.nnoremap("<C-f>", "<cmd>lua require'telescope.builtin'.live_grep{ only_sort_text = true }<CR>")
m.nnoremap("<leader>b", "<cmd>lua require'telescope.builtin'.buffers()<CR>")
m.nnoremap("<C-g>", "<cmd>lua require'telescope.builtin'.git_branches()<CR>")
m.nnoremap("<leader>w", "<cmd>lua require'telescope'.extensions.git_worktree.git_worktrees()<CR>")
m.nnoremap("<leader>p", "<cmd>lua require'telescope'.extensions.project.project{}<CR>")
