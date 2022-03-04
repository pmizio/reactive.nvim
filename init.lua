local set = vim.opt
local g = vim.g
local fn = vim.fn

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

  use "b0o/mapx.nvim"

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
    "williamboman/nvim-lsp-installer",
    requires = {

      { "neovim/nvim-lspconfig", opt = true },

      { "lukas-reineke/lsp-format.nvim", opt = true },
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
    "L3MON4D3/LuaSnip",
    config = function()
      require "config.luasnip"
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
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require "config.lsp.format"
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
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

  if packer_bootstrap then
    require("packer").sync()
  end
end)

vim.cmd "colorscheme gruvbox"

local m = require "mapx"

m.nnoremap("<ESC>", ":nohl <ESC>", "silent")

-- map jk and kj to esc
m.inoremap("<ESC>", "<NOP>")
m.inoremap("jk", "<C-o>:nohl<CR><ESC>", "silent")
m.inoremap("kj", "<C-o>:nohl<CR><ESC>", "silent")
m.tnoremap("jk", "<C-\\><C-n>", "silent")
m.tnoremap("kj", "<C-\\><C-n>", "silent")

-- disable ex mode
m.map("Q", "<NOP>")

-- map keys for move over code completion
m.inoremap("<C-j>", "<C-n>")
m.inoremap("<C-k>", "<C-p>")

-- map keys for move between splits
m.nnoremap("<C-j>", "<C-w><C-j>")
m.nnoremap("<C-k>", "<C-w><C-k>")
m.nnoremap("<C-l>", "<C-w><C-l>")
m.nnoremap("<C-h>", "<C-w><C-h>")
m.tnoremap("<C-j>", "<C-\\><C-n><C-w><C-j>")
m.tnoremap("<C-k>", "<C-\\><C-n><C-w><C-k>")
m.tnoremap("<C-l>", "<C-\\><C-n><C-w><C-l>")
m.tnoremap("<C-h>", "<C-\\><C-n><C-w><C-h>")
m.map("<leader>m", "<C-w>o", "silent")

-- map keys for moving lines up and down
local Aj = fn.has "macunix" and "∆" or "<A-j>"
local Ak = fn.has "macunix" and "Ż" or "<A-k>"
m.nnoremap(Aj, ":m .+1<CR>==", "silent")
m.nnoremap(Ak, ":m .-2<CR>==", "silent")
m.vnoremap(Aj, ":m '>+1<CR>gv=gv", "silent")
m.vnoremap(Ak, ":m '<-2<CR>gv=gv", "silent")

-- map keys for yank and paste over system clipboard
m.nmap("gp", '"+p')
m.nmap("gP", '"+P')
m.vmap("gp", '"+p')
m.vmap("gP", '"+P')
-- yank
m.nmap("gy", '"+y')
m.nmap("gY", '"+Y')
m.vmap("gy", '"+y')
m.vmap("gY", '"+Y')

m.nnoremap("<leader>nn", ":NvimTreeToggle<CR>", "silent")
m.nnoremap("<leader>nf", ":NvimTreeFindFile<CR>", "silent")

function BaseCommit()
  vim.cmd [[
    let b = substitute(system('git branch --show-current'), '^\(\w\+\/\)\?\([A-Z0-9]\+-\d\+\)-.*$', '\2', 'g')
    call nvim_buf_set_lines(0, 0, -1, v:false, [ b . " | " ])
    :startinsert!
  ]]
end

function ReloadConfig()
  require("plenary.reload").reload_module("config", true)
  dofile(vim.env.MYVIMRC)
  vim.cmd "PackerCompile"
end

m.nnoremap("<leader>gc", BaseCommit)

vim.cmd [[
function! ToggleTreeWidth(size)
  if winwidth('%') < a:size
    exe "vertical resize +" . a:size
  else
    exe "vertical resize -" . a:size
  endif
endfunction

au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
au FileType gitcommit au BufEnter <buffer> lua BaseCommit()

command! SoConf lua ReloadConfig()<CR>
]]
