local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/29cbfe9a2504cfae30bae938bdb2be6081ccc5c8/lib/protocol.d.ts#L1305

local convert_text_changes = function(file, content_changes)
  local reversed_content_changes = {}

  -- INFO: tsserver weird beast it process changes in reversed order, but IDK in all cases this assumption is ok
  for _, change in ipairs(content_changes) do
    table.insert(
      reversed_content_changes,
      1,
      vim.tbl_extend(
        "force",
        { newText = change.text },
        utils.convert_lsp_range_to_tsserver(change.range)
      )
    )
  end

  return {
    fileName = file,
    textChanges = reversed_content_changes,
  }
end

local change_request_handler = function(_, params)
  local text_document = params.textDocument
  local content_changes = params.contentChanges

  return {
    command = constants.CommandTypes.UpdateOpen,
    arguments = {
      changedFiles = {
        convert_text_changes(vim.uri_to_fname(text_document.uri), content_changes),
      },
      closedFiles = {},
      openFiles = {},
    },
  }
end

return {
  request = { method = constants.LspMethods.DidChange, handler = change_request_handler },
}
