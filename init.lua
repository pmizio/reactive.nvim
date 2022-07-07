require "config.utils.globals"
require "config.options"
require "config.commands"
require "config.mappings"

-- plugins
require "plugins"

-- treesitter
require "config.treesitter"

-- lsp
require "config.lsp"
require "config.lsp.format"
require "config.lsp.cmp"

-- snippets
require "config.luasnip"

-- telescope
require "config.telescope"

-- editing support
require "config.comment"
require "config.substitute"
require "config.quickScope"
require("nvim-surround").setup {}

-- widgets
require "config.lualine"
require "config.nvimtree"

-- git
require "config.git"

-- utils
require "config.trueZen"
require "config.fterm"
require "config.harpoon"
require "config.hardTime"
require "config.undotree"
require "config.norg"
require("dressing").setup {}
require("todo-comments").setup {}

vim.cmd "colorscheme tokyonight"

pcall(require, "config.neovide")
pcall(require, "config.scratchpad")
