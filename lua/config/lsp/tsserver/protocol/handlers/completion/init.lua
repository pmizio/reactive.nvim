local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference
-- https//github.com/microsoft/TypeScript/blob/8b482b513d87c6fcda8ece18b99f8a01cff5c605/lib/protocol.d.ts#L1631
local completion_request_handler = function(_, params)
  local text_document = params.textDocument
  local context = params.context or {}
  local req = {
    command = constants.CommandTypes.CompletionInfo,
    arguments = vim.tbl_extend("force", {
      file = vim.uri_to_fname(text_document.uri),
      triggerKind = context.triggerKind,
      triggerCharacter = context.triggerCharacter,
    }, utils.convert_lsp_position_to_tsserver(params.position)),
  }
  return req
end

local completion_response_handler = function(_, body)
  if not body then
    return {}
  end

  return vim.tbl_map(function(item)
    return {
      label = item.name,
      kind = 7,
      sortText = item.sortText,
    }
  end, body.entries or {})
end

return {
  request = { method = constants.LspMethods.Completion, handler = completion_request_handler },
  response = {
    method = constants.CommandTypes.CompletionInfo,
    handler = completion_response_handler,
  },
}
