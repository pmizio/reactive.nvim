return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    require "plugins.luasnip.lua"
    require "plugins.luasnip.ts"
  end,
}
