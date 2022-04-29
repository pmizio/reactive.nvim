local M = {}
local globalAuGroup = vim.api.nvim_create_augroup("GlobalAuGroup", { clear = true })

function M.resize_split_by(size, opts)
  opts = opts or { add = true }

  local mul = opts.add and 1 or -1
  local width = vim.api.nvim_win_get_width(0)

  vim.api.nvim_win_set_width(0, width + size * mul)
end

function M.create_onetime_autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", opts, { group = globalAuGroup }))
end

return M
