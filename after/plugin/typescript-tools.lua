local ok, tst = pcall(require,"typescript-tools")

if not ok then
	return
end

tst.setup {
  settings = {
    composite_mode = "separate_diagnostic",
    publish_diagnostic_on = "insert_leave",
  },
}
