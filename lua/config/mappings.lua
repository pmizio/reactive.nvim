local fn = vim.fn
local m = require "config.utils.map"

m.nmap("<ESC>", ":nohl <ESC>")
m.tmap("<ESC>", "<C-\\><C-n>")

-- disable ex mode
m.map("", "Q", "<NOP>")

-- autocomplete remappings
m.remap({ "i", "c" }, "<C-j>", "<C-n>")
m.remap({ "i", "c" }, "<C-k>", "<C-p>")

-- map keys for move between splits
m.nmap("<C-j>", "<C-w><C-j>")
m.nmap("<C-k>", "<C-w><C-k>")
m.nmap("<C-l>", "<C-w><C-l>")
m.nmap("<C-h>", "<C-w><C-h>")

-- map keys for moving lines up and down
local Aj = fn.has "macunix" == 1 and "∆" or "<A-j>"
local Ak = fn.has "macunix" == 1 and "Ż" or "<A-k>"
m.nmap(Aj, ":m .+1<CR>==")
m.nmap(Ak, ":m .-2<CR>==")
m.vmap(Aj, ":m '>+1<CR>gv=gv")
m.vmap(Ak, ":m '<-2<CR>gv=gv")

-- fix indenting using < and >
m.vmap(">", ">gv")
m.vmap("<", "<gv")

-- map keys for yank and paste over system clipboard
m.map({ "n", "v" }, "gp", '"+p')
m.map({ "n", "v" }, "gP", '"+P')

-- yank
m.map({ "n", "v" }, "gy", '"+y')
m.map({ "n", "v" }, "gY", '"+Y')

-- remap n to also center search result
m.nmap("n", "nzzzv")
