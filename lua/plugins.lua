local fn = vim.fn

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
  use "wbthomason/packer.nvim"
  use "lewis6991/impatient.nvim"

  --colorscheme
  use "folke/tokyonight.nvim"

  -- common deps
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "lukas-reineke/indent-blankline.nvim"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } }

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "ray-x/lsp_signature.nvim"
  use "simrat39/rust-tools.nvim"
  use "folke/lua-dev.nvim"
  use "j-hui/fidget.nvim"

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "onsails/lspkind-nvim"

  -- format
  use "lukas-reineke/lsp-format.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- snippets
  use "L3MON4D3/LuaSnip"

  -- editing support
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use "numToStr/Comment.nvim"
  use "kylechui/nvim-surround"
  use "gbprod/substitute.nvim"
  use "tpope/vim-repeat"
  use "jinh0/eyeliner.nvim"
  use "andymass/vim-matchup"

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "ThePrimeagen/git-worktree.nvim"
  use "nvim-telescope/telescope-project.nvim"

  -- widgets
  use "kyazdani42/nvim-web-devicons"

  use "kyazdani42/nvim-tree.lua"
  use "hoob3rt/lualine.nvim"
  use { "kevinhwang91/nvim-bqf", ft = "qf" }

  -- git
  use "tpope/vim-fugitive"
  use "lewis6991/gitsigns.nvim"

  -- utils
  use "Pocco81/TrueZen.nvim"
  use "numToStr/FTerm.nvim"
  use "ThePrimeagen/harpoon"
  use "rgroli/other.nvim"
  use "takac/vim-hardtime"
  use "mbbill/undotree"
  use "stevearc/dressing.nvim"
  use "folke/todo-comments.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)
