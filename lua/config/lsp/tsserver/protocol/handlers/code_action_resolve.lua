local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/b0795e9c94757a8ee78077d160cde8819a9801ea/lib/protocol.d.ts#L469
local code_action_resolve_request_handler = function(_, params)
  return {
    command = constants.CommandTypes.GetEditsForRefactor,
    arguments = params.data,
  }
end

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/b0795e9c94757a8ee78077d160cde8819a9801ea/lib/protocol.d.ts#L481
local code_action_resolve_response_handler = function(_, body, request_param)
  -- TODO: tsserver refactors also return position where invoke rename to rename new fn/var - handle it somehow
  return {
    title = request_param.data.refactor,
    kind = request_param.data.kind,
    edit = {
      changes = utils.convert_tsserver_edits_to_lsp(body.edits),
    },
  }
end

return {
  request = {
    method = constants.LspMethods.CodeActionResolve,
    handler = code_action_resolve_request_handler,
  },
  response = {
    method = constants.CommandTypes.GetEditsForRefactor,
    handler = code_action_resolve_response_handler,
  },
}
