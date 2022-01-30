local fn = vim.fn

local luasnip = require "luasnip"
local snippet = luasnip.snippet
local f = luasnip.function_node

local M = {}

function M.indent()
  if vim.opt.expandtab:get() then
    return string.rep(" ", vim.opt.tabstop:get())
  end

  return "\t"
end

function M.print_snip(suffix, fn_name)
  fn_name = fn_name or suffix

  return {
    snippet(
      { trig = "(%s*)(.+)%." .. suffix, regTrig = true, hidden = true },
      f(function(_, snip)
        return snip.captures[1] .. fn_name .. "(" .. snip.captures[2] .. ")"
      end, {})
    ),
  }
end

function M.file_name(without_spec)
  return f(function()
    local name = fn.expand "%:t:r"

    if without_spec then
      return name:gsub(".spec", "")
    end

    return name
  end, {})
end

function M.match_to_list(iterator)
  local ret = {}

  for v in iterator do
    table.insert(ret, v)
  end

  return ret
end

function M.get_diagnostic_for_line(from_server, offset)
  local ret = {}
  local currLine = vim.api.nvim_win_get_cursor(0)[1]

  for _, v in ipairs(vim.diagnostic.get()) do
    if v.lnum + 1 + (offset or 0) * -1 == currLine then
      if not from_server then
        table.insert(ret, v)
      elseif v.source == from_server then
        table.insert(ret, v)
      end
    end
  end

  return ret
end

return M
