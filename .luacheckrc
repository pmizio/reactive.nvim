---@diagnostic disable: lowercase-global
-- luacheck: globals ignore exclude_files globals read_globals
ignore = {
  "631", -- max_line_length
}
exclude_files = {
  ".tests",
}
globals = { "vim", "P" }
read_globals = {
  "describe",
  "it",
  "after_each",
  "assert",
}
