local fn = vim.fn

require "config.utils.globals"
require "config.options"
require "config.commands"
require "config.mappings"

pcall(require, "config.neovide")

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
      require("fidget").setup { text = { spinner = "moon" } }
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
    config = function()
      require "config.fugitive"
    end,
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

  use {
    "Pocco81/TrueZen.nvim",
    config = function()
      require "config.trueZen"
    end,
  }
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

  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd "colorscheme tokyonight"
    end,
  }

  use {
    "takac/vim-hardtime",
    config = function()
      require "config.hardTime"
    end,
  }

  use {
    "mbbill/undotree",
    config = function()
      require "config.undotree"
    end,
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

pcall(require, "config.scratchpad")
