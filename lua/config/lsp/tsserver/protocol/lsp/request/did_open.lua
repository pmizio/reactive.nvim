local log = require "vim.lsp.log"
local constants = require("config.lsp.tsserver.protocol").constants
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/29cbfe9a2504cfae30bae938bdb2be6081ccc5c8/lib/protocol.d.ts#L1214

return function(encode_and_send, _, params)
  local text_document = params.textDocument

  local req = {
    command = constants.CommandTypes.Open,
    arguments = {
      file = vim.uri_to_fname(text_document.uri),
      fileContent = text_document.text,
      scriptKindName = utils.get_text_document_script_kind(text_document),
    },
  }

  encode_and_send(req)
end
