local fn = vim.fn

local luasnip = require "luasnip"
local snippet = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

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

function M.var_snip(abbr, keyword)
  return snippet(
    { trig = "([%w.%[%]'\"?]+)%." .. abbr, regTrig = true, hidden = true },
    fmt(keyword .. " {} = {}", {
      i(0),
      f(function(_, snip)
        return snip.captures[1]
      end, {}),
    })
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

function M.mirror(index, callback)
  return f(function(args)
    if callback then
      return callback(args)
    end

    return args[1]
  end, {
    index,
  })
end

return M
