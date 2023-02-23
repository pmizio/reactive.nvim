local on_attach = require "pmizio.on_attach"
local utils = require "pmizio.utils"

local ok, tst = pcall(require, "typescript-tools")

if not ok or utils.is_npm_installed "vue" then
  return
end

tst.setup {
  on_attach=on_attach,
  settings = {
    composite_mode = "separate_diagnostic",
    publish_diagnostic_on = "insert_leave",
  },
}
