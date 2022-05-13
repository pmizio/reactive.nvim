local set = vim.opt
local g = vim.g
local fn = vim.fn
local map = vim.keymap.set
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

vim.cmd "cabbrev wqa Wqa"

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
    run = ":TSUpdate",
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
      { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
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
      "ray-x/lsp_signature.nvim",
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
    event = "BufEnter",
    config = function()
      require "config.lsp.format"
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
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

  use "tpope/vim-surround"

  use {
    "gbprod/substitute.nvim",
    config = function()
      require "config.substitute"
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

  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  }

  use {
    "unblevable/quick-scope",
    config = function()
      require "config.quickScope"
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

-- autocomplete remappings
map({ "i", "c" }, "<C-j>", "<C-n>", { remap = true })
map({ "i", "c" }, "<C-k>", "<C-p>", { remap = true })

-- map keys for move between splits
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("", "<leader>m", "<C-w>o", { silent = true })

-- map keys for moving lines up and down
local Aj = fn.has "macunix" == 1 and "∆" or "<A-j>"
local Ak = fn.has "macunix" == 1 and "Ż" or "<A-k>"
map("n", Aj, ":m .+1<CR>==", { silent = true })
map("n", Ak, ":m .-2<CR>==", { silent = true })
map("v", Aj, ":m '>+1<CR>gv=gv", { silent = true })
map("v", Ak, ":m '<-2<CR>gv=gv", { silent = true })

-- map keys for yank and paste over system clipboard
map({ "n", "v" }, "gp", '"+p')
map({ "n", "v" }, "gP", '"+P')

-- yank
map({ "n", "v" }, "gy", '"+y')
map({ "n", "v" }, "gY", '"+Y')

function ReloadConfig()
  local config_prefix = fn.fnamemodify(vim.env.MYVIMRC, ":p:h") .. "/lua/"
  local lua_dirs = fn.glob(config_prefix .. "**", 0, 1)

  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(fn.fnamemodify(dir, ":r"), config_prefix, "")
    require("plenary.reload").reload_module(dir, true)
    pcall(require, dir)
  end
  dofile(vim.env.MYVIMRC)
end

function P(v)
  print(vim.inspect(v))
  return v
end

function RL(module)
  require("plenary.reload").reload_module(module)
  return require(module)
end

vim.api.nvim_create_user_command("Wqa", "wa | qa", { force = true })
vim.api.nvim_create_user_command("R", ReloadConfig, { force = true })

one_au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

one_au("FileType", {
  pattern = "gitcommit",
  callback = function()
    local branch = fn.system("git branch --show-current"):match "/?([%u%d]+-%d+)-?"

    if branch then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { branch .. " | " })
      vim.cmd ":startinsert!"
    end
  end,
})

pcall(require, "config.scratchpad")
