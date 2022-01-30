require("Comment").setup {
  pre_hook = function()
    return require("ts_context_commentstring.internal").calculate_commentstring()
  end,
}
