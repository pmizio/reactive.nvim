local ts = vim.treesitter
local ts_utils = require "nvim-treesitter.ts_utils"

local function goto_translation()
  local ft = vim.bo.filetype

  if not string.find(ft, "[java|type]script") then
    return false
  end

  local node = ts_utils.get_node_at_cursor(0)

  while
    node
    and (
      node:type() ~= "call_expression"
      or (
        node:type() == "call_expression"
        and ts.get_node_text(node:field("function")[1], 0) ~= "i18n"
      )
    )
  do
    node = node:parent()
  end

  if not node then
    print 'There is no "i18n" function under cursor!'
    return false
  end

  local args = node:field("arguments")[1]
  local name = ts_utils.get_node_text(args:child(1):child(1), 0)[1]

  if name then
    local po_winid = vim.fn.bufwinid(vim.fn.bufnr "src/translations/pl-PL.po")

    if po_winid == -1 then
      vim.cmd ":vs ./src/translations/pl-PL.po"
    else
      vim.api.nvim_set_current_win(po_winid)
    end
    vim.cmd('/"' .. name .. '"')
    vim.cmd "nohl"

    return true
  end

  return false
end

return goto_translation
