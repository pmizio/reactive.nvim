local fterm = require "FTerm"
local ftutils = require "FTerm.utils"

local ADDITIONAL_TERMINALS_BINDINGS = { "j", "k", "l" }

local DIMENSIONS = {
  height = 0.9,
  width = 0.9,
  y = 0,
}

fterm.setup {}

local terminals = {}

for _, binding in ipairs(ADDITIONAL_TERMINALS_BINDINGS) do
  local term = fterm:new {
    cmd = vim.env.SHELL,
    dimensions = DIMENSIONS,
  }

  local function toggle(key)
    return function()
      local closed_term = false

      for k, t in pairs(terminals) do
        if ftutils.is_win_valid(t.win) then
          t:close()
          closed_term = k
        end
      end

      if closed_term ~= key then
        term:toggle()
      end
    end
  end

  vim.keymap.set("n", "<leader>t" .. binding, toggle(binding))
  vim.keymap.set("t", "<leader>t" .. binding, toggle(binding))

  terminals[binding] = term
end

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-j>", "<DOWN>")
vim.keymap.set("t", "<C-k>", "<UP>")
vim.keymap.set("t", "<C-l>", "<RIGHT>")
vim.keymap.set("t", "<C-h>", "<LEFT>")
