local fn = vim.fn
local m = require "config.utils.map"

m.nnoremap("<ESC>", ":nohl <ESC>")

-- map jk and kj to esc
m.inoremap("<ESC>", "<NOP>")
m.inoremap("jk", "<C-o>:nohl<CR><ESC>")
m.inoremap("kj", "<C-o>:nohl<CR><ESC>")
m.tnoremap("jk", "<C-\\><C-n>")
m.tnoremap("kj", "<C-\\><C-n>")

-- disable ex mode
m.noremap("", "Q", "<NOP>")

-- autocomplete remappings
m.map({ "i", "c" }, "<C-j>", "<C-n>")
m.map({ "i", "c" }, "<C-k>", "<C-p>")

-- map keys for move between splits
m.nnoremap("<C-j>", "<C-w><C-j>")
m.nnoremap("<C-k>", "<C-w><C-k>")
m.nnoremap("<C-l>", "<C-w><C-l>")
m.nnoremap("<C-h>", "<C-w><C-h>")

-- map keys for moving lines up and down
local Aj = fn.has "macunix" == 1 and "∆" or "<A-j>"
local Ak = fn.has "macunix" == 1 and "Ż" or "<A-k>"
m.nnoremap(Aj, ":m .+1<CR>==")
m.nnoremap(Ak, ":m .-2<CR>==")
m.vnoremap(Aj, ":m '>+1<CR>gv=gv")
m.vnoremap(Ak, ":m '<-2<CR>gv=gv")

-- map keys for yank and paste over system clipboard
m.noremap({ "n", "v" }, "gp", '"+p')
m.noremap({ "n", "v" }, "gP", '"+P')

-- yank
m.noremap({ "n", "v" }, "gy", '"+y')
m.noremap({ "n", "v" }, "gY", '"+Y')
