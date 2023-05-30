local on_attach = require "pmizio.on_attach"
local utils = require "pmizio.utils"

local ok, tst = pcall(require, "typescript-tools")

if not ok or utils.is_npm_installed "vue" then
  return
end

tst.setup {
  on_attach = function(client, bufnr)
    -- client.server_capabilities.semanticTokensProvider = false
    on_attach(client, bufnr)
  end,
  settings = {
    separate_diagnostic_server = true,
    composite_mode = "separate_diagnostic",
    publish_diagnostic_on = "insert_leave",
    -- tsserver_plugins = { "typescript-styled-plugin" },
    -- tsserver_format_options = {
    --   tabSize = 4,
    --   indentSize = 4,
    --   convertTabsToSpaces = false,
    --   newLineCharacter = "\r\n",
    -- },
    tsserver_logs = "verbose",
    -- tsserver_logs = {
    --   verbosity = "verbose",
    --   file_basename = "/Users/pawel.mizio/.config/nvim/",
    -- },
    code_lens = "all",
    disable_member_code_lens = true,
  },
}
