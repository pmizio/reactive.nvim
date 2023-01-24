require("typescript-tools").setup {
  settings = {
    composite_mode = "separate_diagnostic",
    publish_diagnostic_on = "insert_leave",
  },
}
