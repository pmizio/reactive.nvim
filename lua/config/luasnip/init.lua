local luasnip = require "luasnip"
local m = require "config.utils.map"

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

luasnip.snippets = {}

require "config.luasnip.ts"
require "config.luasnip.lua"

m.imap("<C-n>", function()
  luasnip.jump(1)
end)
m.imap("<C-p>", function()
  luasnip.jump(-1)
end)
