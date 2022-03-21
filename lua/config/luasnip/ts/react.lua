local luasnip = require "luasnip"
local utils = require "config.luasnip.utils"

local snippet = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  snippet("rfc", {
    t { "import React from 'react';", "", "const " },
    utils.file_name(),
    t { " = () => {", utils.indent() },
    i(0),
    t { "", "}" },
  }),
  snippet(
    "eff",
    fmt(
      [[
      useEffect(() => {{
        {}
      }}, [{}])
      ]],
      { i(1), i(0) }
    )
  ),
  snippet(
    { trig = "(%w+)%.useState", regTrig = true, hidden = true },
    f(function(_, snip)
      local name = snip.captures[1]
      return "const [" .. name .. ", set" .. name:gsub("^%l", string.upper) .. "] = useState()"
    end, {})
  ),
}
