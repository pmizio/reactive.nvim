return {
  "takac/vim-hardtime",
  lazy = false,
  init = function()
    vim.g.hardtime_default_on = 1
  end,
  config = function()
    vim.g.hardtime_maxcount = 2
    vim.g.hardtime_ignore_quickfix = 1
    vim.g.list_of_normal_keys =
      { "h", "j", "k", "l", "<LEFT>", "<UP>", "<DOWN>", "<RIGHT>", "w", "W", "b", "B" }
    vim.g.list_of_insert_keys = { "<LEFT>", "<UP>", "<DOWN>", "<RIGHT>" }
    vim.g.hardtime_ignore_buffer_patterns = {
      "fugitive://.*",
      "\\.git/.*/\\?index",
      "\\.git/COMMIT_EDITMSG",
      "\\.git/rebase-merge.*",
      "undotree_2",
      "runtime/doc/.*.txt",
    }
  end,
}
