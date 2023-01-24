local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- START COMMON DEPS --
  "lewis6991/impatient.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        color_icons = true,
        default = true,
      }
    end,
  },
  -- END COMMON DEPS --
  "folke/tokyonight.nvim",
  -- START TREESITTER --
  { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead", lazy = true },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle", lazy = true },
  -- START LSP --
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",

      -- Snippets
      "L3MON4D3/LuaSnip",

      -- eyecany things
      "onsails/lspkind.nvim",
      "j-hui/fidget.nvim",
    },
  },
  { dir = "~/Documents/GitHub/typescript-tools.nvim" },
  -- END LSP --
  -- START FORMATTING --
  "lukas-reineke/lsp-format.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jay-babu/mason-null-ls.nvim",
  -- END FORMATTING --
  -- START TELESCOPE --
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  -- END TELESCOPE --
  -- START GIT --
  { "tpope/vim-fugitive", cmd = { "G", "Git" }, lazy = true },
  "lewis6991/gitsigns.nvim",
  -- END GIT --
  -- START COMMENT --
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",
  -- END COMMENT --
  -- START EDITING SUPPORT --
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  "jinh0/eyeliner.nvim",
  -- END EDITING SUPPORT --
  "mbbill/undotree",
  "tpope/vim-repeat",
  "lukas-reineke/indent-blankline.nvim",
  { "kyazdani42/nvim-tree.lua", tag = "nightly" },
  "akinsho/toggleterm.nvim",
  "hoob3rt/lualine.nvim",
  { "kevinhwang91/nvim-bqf", ft = "qf", lazy = true },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },
}
