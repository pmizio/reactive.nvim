local fn = vim.fn
local luasnip = require "luasnip"
local snippet = luasnip.snippet
local f = luasnip.function_node

local M = {}

function M.print_snip(suffix, fn_name)
  fn_name = fn_name or suffix

  return snippet(
    { trig = "(%s*)(.+)%." .. suffix, regTrig = true, hidden = true },
    f(function(_, snip)
      return snip.captures[1] .. fn_name .. "(" .. snip.captures[2] .. ")"
    end, {})
  )
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

return M
