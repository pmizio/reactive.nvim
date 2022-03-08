local map = vim.keymap.set
local luasnip = require "luasnip"

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

luasnip.snippets = {}

require "config.luasnip.ts"
require "config.luasnip.lua"

map("i", "<C-n>", function()
  luasnip.jump(1)
end)
map("i", "<C-p>", function()
  luasnip.jump(-1)
end)
