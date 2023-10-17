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

require("lazy").setup({
  -- START COMMON DEPS --
  { "lewis6991/impatient.nvim", lazy = false },
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-tree/nvim-web-devicons",
  -- END COMMON DEPS --
  -- START VISUALS --
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyonight"
    end,
  },
  { "stevearc/dressing.nvim", lazy = false, opts = {} },
  { "folke/todo-comments.nvim", event = "BufReadPre", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", event = "BufReadPre", main = "ibl", opts = {} },
  -- END VISUALS --
  -- START EDITING SUPPORT --
  { "kylechui/nvim-surround", keys = { "cs", "ds", "ys" }, opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = { check_ts = true } },
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
  -- END EDITING SUPPORT --
  { "christoomey/vim-tmux-navigator", keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" } },
  { "tpope/vim-repeat", keys = { "." } },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { import = "plugins" },
}, {
  defaults = { lazy = true },
})
