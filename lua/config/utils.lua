local M = {}

function M.resize_split_by(size, opts)
  opts = opts or { add = true }

  local width = vim.api.nvim_win_get_width(0)

  vim.api.nvim_win_set_width(0, width + (size * (opts.add and 1 or -1)))
end

return M
