local constants = require "config.lsp.tsserver.protocol.constants"

function CheckDocs()
  for _, v in pairs(vim.tbl_values(constants.LspMethods)) do
    local method = string.gsub(v, "/", "\\/")
    local cmd = string.format("silent! %%s/- . . %s/- [x] %s/g", method, method)

    P(cmd)
    vim.cmd(cmd)
  end
end
