local luasnip = require "luasnip"
local utils = require "config.luasnip.utils"

luasnip.add_snippets("lua", vim.list_extend({}, utils.print_snip("log", "print")))
