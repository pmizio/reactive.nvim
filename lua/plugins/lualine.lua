return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  opts = {
    options = {
      theme = "tokyonight",
      component_separators = {},
      section_separators = {},
      globalstatus = true,
    },
    extensions = { "nvim-tree", "quickfix" },
  },
}
