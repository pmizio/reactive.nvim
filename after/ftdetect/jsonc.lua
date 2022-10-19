-- Set correct filetype to stop lsp is not yelling about comments
vim.filetype.add {
  filename = {
    [".eslintrc"] = "jsonc",
    [".eslintrc.json"] = "jsonc",
  },
  pattern = {
    ["[jt]sconfig%.json"] = "jsonc",
  },
}
