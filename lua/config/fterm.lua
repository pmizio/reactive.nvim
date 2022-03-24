local fterm = require "FTerm"

local ADDITIONAL_TERMINALS_BINDINGS = { "j", "k", "l" }

local DIMENSIONS = {
  height = 0.9,
  width = 0.9,
  y = 0,
}

fterm.setup {}

for _, binding in ipairs(ADDITIONAL_TERMINALS_BINDINGS) do
  local term = fterm:new {
    cmd = vim.env.SHELL,
    dimensions = DIMENSIONS,
  }

  local function toggle()
    term:toggle()
  end

  vim.keymap.set("n", "<leader>t" .. binding, toggle)
  vim.keymap.set("t", "<leader>t" .. binding, toggle)
end

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-j>", "<DOWN>")
vim.keymap.set("t", "<C-k>", "<UP>")
vim.keymap.set("t", "<C-l>", "<RIGHT>")
vim.keymap.set("t", "<C-h>", "<LEFT>")
