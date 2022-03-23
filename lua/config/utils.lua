local M = {}

function M.resize_split_by(size, opts)
  opts = opts or { add = true }

  vim.cmd("vertical resize " .. (opts.add and "+" or "-") .. size)
end

return M
