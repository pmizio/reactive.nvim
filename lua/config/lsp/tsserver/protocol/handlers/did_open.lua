local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/29cbfe9a2504cfae30bae938bdb2be6081ccc5c8/lib/protocol.d.ts#L1214

local open_request_handler = function(_, params)
  local text_document = params.textDocument

  return {
    command = constants.CommandTypes.Open,
    arguments = {
      file = vim.uri_to_fname(text_document.uri),
      fileContent = text_document.text,
      scriptKindName = utils.get_text_document_script_kind(text_document),
    },
  }
end

return {
  request = { method = constants.LspMethods.DidOpen, handler = open_request_handler },
}
