local M = {}

function P(arg)
  print(vim.inspect(arg))
end

local pmizioGroup = vim.api.nvim_create_augroup("PmizioGroup", { clear = true })

M.config_autocmd = function(event, opts)
  vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", opts, { group = pmizioGroup }))
end

M.resize_split_by = function(size, opts)
  opts = opts or { add = true }

  local mul = opts.add and 1 or -1
  local width = vim.api.nvim_win_get_width(0)

  vim.api.nvim_win_set_width(0, width + size * mul)
end

return M
