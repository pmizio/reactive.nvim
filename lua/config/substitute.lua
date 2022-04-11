require("substitute").setup {}

local function noremap(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

noremap("n", "s", require("substitute").operator)
noremap("n", "ss", require("substitute").line)
noremap("n", "S", require("substitute").eol)
noremap("x", "s", require("substitute").visual)

noremap("n", "sx", require("substitute.exchange").operator)
noremap("n", "sxx", require("substitute.exchange").line)
noremap("x", "X", require("substitute.exchange").visual)
noremap("n", "sxc", require("substitute.exchange").cancel)
