local set = vim.opt
local g = vim.g
local one_au = require("config.utils").create_onetime_autocmd

vim.cmd "filetype indent off"
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = false
set.cindent = false
set.smartindent = false
set.ignorecase = true
set.smartcase = true
set.swapfile = false
set.backup = false
set.writebackup = false
set.completeopt = { "menu", "menuone", "noselect" }
set.signcolumn = "yes"
set.cmdheight = 2
set.updatetime = 50
set.shortmess:append "c"
set.colorcolumn = "100"
set.splitright = true
set.cursorline = true
set.termguicolors = true
set.pumheight = 10
set.diffopt:append "vertical"
set.inccommand = "split"

g.mapleader = " "

vim.cmd "cabbrev wqa Wqa"

one_au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- Set correct filetype to stop lsp is not yelling about comments
one_au({ "BufNewFile", "BufRead" }, {
  pattern = { "*eslint*.json", "tsconfig.json", "jsconfig.json" },
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})
