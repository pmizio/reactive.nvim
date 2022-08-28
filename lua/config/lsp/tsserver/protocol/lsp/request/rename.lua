local log = require "vim.lsp.log"
local constants = require("config.lsp.tsserver.protocol").constants
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference:
-- https://github.com/microsoft/TypeScript/blob/29cbfe9a2504cfae30bae938bdb2be6081ccc5c8/lib/protocol.d.ts#L930

return function(encode_and_send, _, params)
  local text_document = params.textDocument

  encode_and_send {
    command = constants.CommandTypes.Rename,
    arguments = vim.tbl_extend("force", {
      file = vim.uri_to_fname(text_document.uri),
      -- TODO: expose as options
      findInComments = false,
      findInStrings = false,
    }, utils.convert_lsp_position_to_tsserver(params.position)),
  }
end
