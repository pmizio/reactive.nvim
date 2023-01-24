local map = vim.keymap.set
local fn = vim.fn

map("n", "<ESC>", ":nohl <ESC>")

-- disable ex mode
map("", "Q", "<NOP>")

-- map keys for move between splits
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<leader>wj", "<C-w>J")
map("n", "<leader>wk", "<C-w>K")
map("n", "<leader>wl", "<C-w>L")
map("n", "<leader>wh", "<C-w>H")

-- map keys for moving lines up and down
local Aj = fn.has "macunix" == 1 and "∆" or "<A-j>"
local Ak = fn.has "macunix" == 1 and "Ż" or "<A-k>"
map("n", Aj, ":m .+1<CR>==")
map("n", Ak, ":m .-2<CR>==")
map("v", Aj, ":m '>+1<CR>gv=gv")
map("v", Ak, ":m '<-2<CR>gv=gv")

-- fix indenting using < and >
map("v", ">", ">gv")
map("v", "<", "<gv")

-- map keys for yank and paste over system clipboard
map({ "n", "v" }, "gp", '"+p')
map({ "n", "v" }, "gP", '"+P')

-- yank
map({ "n", "v" }, "gy", '"+y')
map({ "n", "v" }, "gY", '"+Y')

-- remap n to also center search result
map("n", "n", "nzzzv")

map("n", "<C-d>", "<C-d>zzzv")
map("n", "<C-u>", "<C-u>zzzv")

-- terminal
map("t", "<ESC>", "<C-\\><C-n>")
