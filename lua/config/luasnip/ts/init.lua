local luasnip = require "luasnip"
local utils = require "config.luasnip.utils"

local snippet = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local jsTsSnippets = {
  snippet(
    "arrf",
    fmt(
      [[
      const {} = () => {{
        {}
      }}
      ]],
      { utils.file_name(), i(1) }
    )
  ),
  snippet("cst", fmt("const {} = {};", { i(1), i(2) })),
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

vim.list_extend(jsTsSnippets, require "config.luasnip.ts.react")

for _, suffix in pairs { "log", "dir", "error" } do
  vim.list_extend(jsTsSnippets, utils.print_snip(suffix, "console." .. suffix))
end

for _, ft in pairs { "javascript", "javascriptreact", "typescript", "typescriptreact" } do
  -- luasnip.snippets[ft] = jsTsSnippets
  luasnip.add_snippets(ft, jsTsSnippets)
end
