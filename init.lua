local set = vim.opt
local g = vim.g
local fn = vim.fn
local map = vim.keymap.set

vim.cmd "filetype indent off"
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = false
set.cindent = false
set.smartindent = false
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

g.mapleader = " "

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

require("packer").startup(function(use)
  use "lewis6991/impatient.nvim"
  use "wbthomason/packer.nvim"

  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup {}
        end,
      },
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "lukas-reineke/indent-blankline.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim", opt = true } },
    },
    config = function()
      require "config.treesitter"
    end,
  }

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      require "config.lsp"
    end,
  }

  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  }

  use {
    "lukas-reineke/lsp-format.nvim",
    requires = "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "config.lsp.format"
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
    config = function()
      require "config.lsp.cmp"
    end,
  }

  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require "config.luasnip"
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "ThePrimeagen/git-worktree.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    config = function()
      require "config.telescope"
    end,
  }

  use {
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require "config.lualine"
    end,
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      require "config.nvimtree"
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require "config.comment"
    end,
  }

  use { "kevinhwang91/nvim-bqf", ft = "qf" }

  use {
    "ThePrimeagen/harpoon",
    config = function()
      require "config.harpoon"
    end,
  }

  use {
    "tpope/vim-fugitive",
    cmd = { "G" },
  }
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end,
  }

  use "tpope/vim-repeat"
  use "troydm/zoomwintab.vim"
  use {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require "config.norg"
    end,
  }

  use "ggandor/lightspeed.nvim"
  use {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup {}
    end,
  }

  use {
    "numToStr/FTerm.nvim",
    config = function()
      require "config.fterm"
    end,
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

vim.cmd "colorscheme gruvbox"

map("n", "<ESC>", ":nohl <ESC>", { silent = true })

-- map jk and kj to esc
map("i", "<ESC>", "<NOP>")
map("i", "jk", "<C-o>:nohl<CR><ESC>", { silent = true })
map("i", "kj", "<C-o>:nohl<CR><ESC>", { silent = true })
map("t", "jk", "<C-\\><C-n>", { silent = true })
map("t", "kj", "<C-\\><C-n>", { silent = true })

-- disable ex mode
map("", "Q", "<NOP>")

-- map keys for move over code completion
map("i", "<C-j>", "<C-n>")
map("i", "<C-k>", "<C-p>")

-- map keys for move between splits
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("t", "<C-j>", "<C-\\><C-n><C-w><C-j>")
map("t", "<C-k>", "<C-\\><C-n><C-w><C-k>")
map("t", "<C-l>", "<C-\\><C-n><C-w><C-l>")
map("t", "<C-h>", "<C-\\><C-n><C-w><C-h>")
map("", "<leader>m", "<C-w>o", { silent = true })

-- map keys for moving lines up and down
local Aj = fn.has "macunix" and "∆" or "<A-j>"
local Ak = fn.has "macunix" and "Ż" or "<A-k>"
map("n", Aj, ":m .+1<CR>==", { silent = true })
map("n", Ak, ":m .-2<CR>==", { silent = true })
map("v", Aj, ":m '>+1<CR>gv=gv", { silent = true })
map("v", Ak, ":m '<-2<CR>gv=gv", { silent = true })

-- map keys for yank and paste over system clipboard
map("n", "gp", '"+p')
map("n", "gP", '"+P')
map("v", "gp", '"+p')
map("v", "gP", '"+P')
-- yank
map("n", "gy", '"+y')
map("n", "gY", '"+Y')
map("v", "gy", '"+y')
map("v", "gY", '"+Y')

map("n", "<leader>nn", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true })

function BaseCommit()
  local b = fn.substitute(
    fn.system("git branch --show-current"):match "^%s*(.-)%s*$",
    "^(w+/)?([A-Z0-9]+-d+)-.*$",
    "\2",
    "g"
  )
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { b .. " | " })
  vim.cmd ":startinsert!"
end

map("n", "<leader>gc", BaseCommit)

ReloadConfig = function()
  local config_prefix = fn.fnamemodify(vim.env.MYVIMRC, ":p:h") .. "/lua/"
  local lua_dirs = fn.glob(config_prefix .. "**", 0, 1)

  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(fn.fnamemodify(dir, ":r"), config_prefix, "")
    require("plenary.reload").reload_module(dir, true)
    pcall(require, dir)
  end
  dofile(vim.env.MYVIMRC)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

vim.cmd [[
command! Wqa wa | qa
cabbrev wqa Wqa

command! R lua ReloadConfig()<CR>

au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
au FileType gitcommit au BufEnter <buffer> lua BaseCommit()

]]
