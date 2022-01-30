local luasnip = require "luasnip"
local m = require "mapx"

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

luasnip.snippets = {}

require "config.luasnip.ts"
require "config.luasnip.lua"

m.inoremap("<C-n>", "<cmd>lua require('luasnip').jump(1)<CR>", "silent")
m.inoremap("<C-p>", "<cmd>lua require('luasnip').jump(-1)<CR>", "silent")
