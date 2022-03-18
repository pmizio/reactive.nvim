require("lualine").setup {
  options = {
    theme = "gruvbox",
    component_separators = {},
    section_separators = {},
    globalstatus = true,
  },
  extensions = { "nvim-tree", "quickfix" },
}
