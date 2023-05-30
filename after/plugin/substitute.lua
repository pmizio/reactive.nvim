local map = vim.keymap.set

local substitute = require "substitute"
local substitute_exchange = require "substitute.exchange"

substitute.setup {}

map("n", "<leader>s", substitute.operator)
map("n", "<leader>ss", substitute.line)
map("n", "<leader>S", substitute.eol)
map("x", "<leader>s", substitute.visual)

map("n", "<leader>x", substitute_exchange.operator)
map("n", "<leader>xx", substitute_exchange.line)
map("n", "<leader>xc", substitute_exchange.cancel)
map("n", "<leader>X", substitute_exchange.visual)
