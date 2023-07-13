vim.g.hardtime_maxcount = 2
vim.g.hardtime_ignore_quickfix = 1
vim.g.list_of_normal_keys = { "h", "j", "k", "l", "w", "W", "b", "B" }
vim.g.hardtime_ignore_buffer_patterns = {
  "fugitive://.*",
  "\\.git/.*/\\?index",
  "\\.git/COMMIT_EDITMSG",
  "\\.git/rebase-merge.*",
  "undotree_2",
  "runtime/doc/.*.txt",
}
