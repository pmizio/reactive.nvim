local luasnip = require "luasnip"
local utils = require "config.luasnip.utils"

local snippet = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  snippet(
    "rfc",
    fmt(
      [[
      import React from 'react';
      
      const {} = () => {{
        {}
      }}
      ]],
      { utils.file_name(), i(1) }
    )
  ),
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
    "useState",
    fmt(
      "const [{}, set{}] = useState()",
      { i(1), utils.mirror(1, function(args)
        return args[1][1]:gsub("^%l", string.upper)
      end) }
    )
  ),
}
