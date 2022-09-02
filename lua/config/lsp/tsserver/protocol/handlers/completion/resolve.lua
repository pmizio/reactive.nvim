local constants = require "config.lsp.tsserver.protocol.constants"
local item_kind_utils = require "config.lsp.tsserver.protocol.handlers.completion.item_kind_utils"
local utils = require "config.lsp.tsserver.protocol.utils"

-- tsserver protocol reference
-- https://github.com/microsoft/TypeScript/blob/549e61d0af1ba885be29d69f341e7d3a00686071/lib/protocol.d.ts#L1661
local completion_request_handler = function(_, params)
  local data = params.data

  if type(data) == "table" then
    return {
      command = constants.CommandTypes.CompletionDetails,
      arguments = vim.tbl_extend("force", {
        file = data.file,
        entryNames = data.entryNames,
        source = data.source,
      }, utils.convert_lsp_position_to_tsserver(data)),
    }
  end

  return {
    command = constants.CommandTypes.CompletionDetails,
    arguments = params.data,
  }
end

local concat_description = function(parts, delim)
  delim = delim or ""
  return table.concat(vim.tbl_map(function(it)
    return it.text
  end, parts) or {}, delim)
end

local make_tags = function(tags)
  return table.concat(vim.tbl_map(function(it)
    local parts = { "\n\n_@" }
    table.insert(parts, it.name)
    table.insert(parts, "_ — `")
    table.insert(parts, concat_description(it.text))
    table.insert(parts, "`")

    return table.concat(parts, "")
  end, tags) or {}, "\n")
end

local completion_response_handler = function(_, body, request_params)
  if body and body[1] then
    local details = body[1]

    P(details.tags)
    table.insert(details.documentation, { text = make_tags(details.tags) })
    return vim.tbl_extend("force", request_params, {
      detail = concat_description(details.displayParts),
      documentation = {
        kind = constants.MarkupKind.Markdown,
        value = concat_description(details.documentation, "\n"),
      },
    })
  end

  return nil
end

return {
  request = {
    method = constants.LspMethods.CompletionResolve,
    handler = completion_request_handler,
  },
  response = {
    method = constants.CommandTypes.CompletionDetails,
    handler = completion_response_handler,
  },
}
