require("lualine").setup {
  options = {
    theme = "gruvbox-baby",
    component_separators = {},
    section_separators = {},
    globalstatus = true,
  },
  extensions = { "nvim-tree", "quickfix" },
}
