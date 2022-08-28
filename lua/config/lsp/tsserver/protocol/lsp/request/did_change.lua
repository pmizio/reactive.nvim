local log = require "vim.lsp.log"
local constants = require("config.lsp.tsserver.protocol").constants
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/29cbfe9a2504cfae30bae938bdb2be6081ccc5c8/lib/protocol.d.ts#L1305

local convert_text_changes = function(file, content_changes)
  return {
    fileName = file,
    textChanges = vim.tbl_map(function(edit)
      return vim.tbl_extend(
        "force",
        { newText = edit.text },
        utils.convert_lsp_range_to_tsserver(edit.range)
      )
    end, content_changes),
  }
end

return function(encode_and_send, _, params)
  local text_document = params.textDocument
  local content_changes = params.contentChanges

  local req = {
    command = constants.CommandTypes.UpdateOpen,
    arguments = {
      changedFiles = {
        convert_text_changes(vim.uri_to_fname(text_document.uri), content_changes),
      },
    },
  }

  encode_and_send(req)
end
