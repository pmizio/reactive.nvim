local luasnip = require "luasnip"
local utils = require "config.luasnip.utils"

local snippet = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node

local BASE_ESLINT_IGNORE = "// eslint-disable-next-line"

local jsTsSnippets = {
  snippet("arrf", {
    t { "const " },
    utils.file_name(),
    t { " = () => {", utils.indent() },
    i(0),
    t { "", "}" },
  }),
  snippet("jds", {
    t "describe('",
    i(1),
    t { "', () => {", utils.indent() },
    i(0),
    t { "", "})" },
  }),
  snippet("jit", {
    t "it('should ",
    i(1),
    t { "', () => {", utils.indent() },
    i(0),
    t { "", "})" },
  }),
  snippet("fln", { utils.file_name(true) }),
  snippet("esi", {
    f(function()
      local errors = utils.get_diagnostic_for_line("eslint", 1)

      if #errors ~= 0 then
        return BASE_ESLINT_IGNORE
          .. " "
          .. table.concat(
            vim.tbl_map(function(v)
              return v.user_data.lsp.code
            end, errors),
            ", "
          )
      end

      return BASE_ESLINT_IGNORE
    end, {}),
  }),
}

vim.list_extend(jsTsSnippets, require "config.luasnip.ts.react")

for _, suffix in pairs { "log", "dir", "error" } do
  vim.list_extend(jsTsSnippets, utils.print_snip(suffix, "console." .. suffix))
end

for _, ft in pairs { "javascript", "javascriptreact", "typescript", "typescriptreact" } do
  luasnip.snippets[ft] = jsTsSnippets
end
