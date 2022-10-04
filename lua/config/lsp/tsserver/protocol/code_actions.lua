local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

--- @class CodeActionsService
--- @field server_type string
--- @field tsserver TsserverInstance
--- @field callback function|nil
--- @field notify_reply_callback function|nil

--- @class CodeActionsService
local CodeActionsService = {}

--- @param server_type string
--- @param tsserver TsserverInstance
function CodeActionsService:new(server_type, tsserver)
  local obj = {
    server_type = server_type,
    tsserver = tsserver,
  }

  setmetatable(obj, self)
  self.__index = self

  return obj
end

--- @param params table
--- @param callback function
--- @param notify_reply_callback function
function CodeActionsService:request(params, callback, notify_reply_callback)
  if self.server_type ~= constants.ServerCompositeType.Primary then
    return
  end

  self.callback = vim.schedule_wrap(callback)
  self.notify_reply_callback = notify_reply_callback and vim.schedule_wrap(notify_reply_callback)
    or nil

  local text_document = params.textDocument
  local start = utils.convert_lsp_position_to_tsserver(params.range.start)
  local _end = utils.convert_lsp_position_to_tsserver(params.range["end"])

  local base_arguments = {
    file = vim.uri_to_fname(text_document.uri),
    startLine = start.line,
    startOffset = start.offset,
    endLine = _end.line,
    endOffset = _end.offset,
  }

  -- tsserver protocol reference:
  -- https://github.com/microsoft/TypeScript/blob/4635a5cef9aefa9aa847ef7ce2e6767ddf4f54c2/lib/protocol.d.ts#L409
  self.tsserver.request_queue:enqueue {
    message = {
      command = constants.CommandTypes.GetApplicableRefactors,
      arguments = base_arguments,
    },
  }

  -- tsserver protocol reference:
  -- https://github.com/microsoft/TypeScript/blob/4635a5cef9aefa9aa847ef7ce2e6767ddf4f54c2/lib/protocol.d.ts#L526
  self.tsserver.request_queue:enqueue {
    message = {
      command = constants.CommandTypes.GetCodeFixes,
      arguments = vim.tbl_extend("force", base_arguments, {
        errorCodes = vim.tbl_map(function(diag)
          return diag.code
        end, params.context.diagnostics),
      }),
    },
  }
end

--- @param response table
function CodeActionsService:handle_response(response)
  if not response.success then
    return
  end

  local command = response.command

  -- tsserver protocol reference:
  -- https://github.com/microsoft/TypeScript/blob/4635a5cef9aefa9aa847ef7ce2e6767ddf4f54c2/lib/protocol.d.ts#L418
  -- TODO: handle refactors response
  if command == constants.CommandTypes.GetApplicableRefactors then
    P(response.body)
  end

  -- tsserver protocol reference:
  -- https://github.com/microsoft/TypeScript/blob/4635a5cef9aefa9aa847ef7ce2e6767ddf4f54c2/lib/protocol.d.ts#L585
  if command == constants.CommandTypes.GetCodeFixes then
    if self.notify_reply_callback then
      self.notify_reply_callback(response.request_seq)
    end

    local code_actions = {}
    local fixes_per_file = {}

    for _, fix in ipairs(response.body) do
      for _, change in ipairs(fix.changes) do
        local uri = vim.uri_from_fname(change.fileName)

        if not fixes_per_file[uri] then
          fixes_per_file[uri] = {}
        end

        for _, edit in ipairs(change.textChanges) do
          table.insert(fixes_per_file[uri], {
            newText = edit.newText,
            range = utils.convert_tsserver_range_to_lsp(edit),
          })
        end
      end

      table.insert(code_actions, {
        title = fix.description,
        kind = "quickfix",
        edit = {
          changes = fixes_per_file,
        },
      })
    end

    if self.callback then
      self.callback(nil, code_actions)
    end
  end
end

return CodeActionsService
