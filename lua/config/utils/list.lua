local M = {}

function M.extend(dst, ...)
  for _, it in ipairs { ... } do
    vim.list_extend(dst, it)
  end

  return dst
end

return M
