local luasnip = require "luasnip"
local utils = require "pmizio.snippet_utils"

local snippet = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local jsTsSnippets = {
  snippet(
    "jds",
    fmt(
      [[
      describe('{}', () => {{
        {}
      }})
      ]],
      { i(1), i(0) }
    )
  ),
  snippet(
    "jit",
    fmt(
      [[
      it('should {}', () => {{
        {}
      }})
      ]],
      { i(1), i(0) }
    )
  ),
  snippet("fln", { utils.file_name(true) }),
}

for _, suffix in pairs { "log", "dir", "error", "trace" } do
  table.insert(jsTsSnippets, utils.print_snip(suffix, "console." .. suffix))
end

for _, ft in pairs { "javascript", "javascriptreact", "typescript", "typescriptreact" } do
  luasnip.add_snippets(ft, jsTsSnippets)
end
