local ok, copilot_cmp = pcall(require, "copilot_cmp")

if not ok then
  return
end

copilot_cmp.setup {}

require("copilot").setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}
