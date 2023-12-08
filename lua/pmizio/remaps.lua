local map = vim.keymap.set
local fn = vim.fn

map("n", "<ESC>", ":nohl <ESC>", { silent = true })

-- disable ex mode
map("", "Q", "<NOP>")

-- move between splits
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")

-- reorder splits
map("n", "<leader>wj", "<C-w>J")
map("n", "<leader>wk", "<C-w>K")
map("n", "<leader>wl", "<C-w>L")
map("n", "<leader>wh", "<C-w>H")

-- moving lines up and down
local Aj = fn.has "macunix" == 1 and "∆" or "<A-j>"
local Ak = fn.has "macunix" == 1 and "Ż" or "<A-k>"
map("n", Aj, ":m .+1<CR>==", { silent = true })
map("n", Ak, ":m .-2<CR>==", { silent = true })
map("v", Aj, ":m '>+1<CR>gv=gv", { silent = true })
map("v", Ak, ":m '<-2<CR>gv=gv", { silent = true })

-- fix indenting using < and >
map("v", ">", ">gv")
map("v", "<", "<gv")

-- yank and paste to system clipboard
map({ "n", "v" }, "gp", '"+p', { silent = true })
map({ "n", "v" }, "gP", '"+P', { silent = true })

-- yank
map({ "n", "v" }, "gy", '"+y', { silent = true })
map({ "n", "v" }, "gY", '"+Y', { silent = true })

-- remap n to also center search result
map("n", "n", "nzzzv")

map("n", "<C-d>", "<C-d>zzzv")
map("n", "<C-u>", "<C-u>zzzv")

-- terminal
map("t", "<ESC>", "<C-\\><C-n>")

-- calc
map("n", "<leader>m", '"zcc<C-r>=<C-r>z<CR><ESC>', { silent = true })
map("v", "<leader>m", '"zc<C-r>=<C-r>z<CR><ESC>', { silent = true })

map("n", "<leader>cp", [[:let @+=expand("%")<CR>]], { silent = true })

local function open_in_gh()
  local user_repo = fn.system("git config --get remote.origin.url")
    :match "https://github%.com/([%w%d-/]+)%.git"

  if user_repo then
    local branch = fn.system("git branch --show-current"):gsub("%s*$", "")
    local file = vim.fn.expand "%:p:~:."
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local gh_url = "https://github.com/"
      .. user_repo
      .. "/blob/"
      .. branch
      .. "/"
      .. file
      .. "#L"
      .. line

    fn.system("open " .. gh_url)
  end
end

vim.keymap.set("n", "<leader>go", open_in_gh)
