require("lualine").setup {
  options = {
    theme = "tokyonight",
    component_separators = {},
    section_separators = {},
    globalstatus = true,
  },
  extensions = { "nvim-tree", "quickfix" },
}
