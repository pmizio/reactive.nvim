local set = vim.opt
local g = vim.g
local config_autocmd = require("pmizio.utils").config_autocmd

vim.cmd "filetype indent off"
vim.g.mapleader = " "
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
set.scrolloff = 10
set.undodir = vim.fn.stdpath "data" .. "/undodir"
set.mouse = ""

g.mapleader = " "

vim.api.nvim_create_user_command("Wqa", "wa | qa", { force = true })
vim.cmd "cabbrev wqa Wqa"
vim.cmd "cabbrev bda 1,$bd"

config_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})
