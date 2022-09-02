local constants = require "config.lsp.tsserver.protocol.constants"
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

local concat_description = function(parts, delim, tag_formatting)
  delim = delim or ""
  return table.concat(vim.tbl_map(function(it)
    if tag_formatting and it.kind == "parameterName" then
      return "`" .. it.text .. "`"
    end

    return it.text
  end, parts) or {}, delim)
end

local make_tags = function(tags)
  return table.concat(vim.tbl_map(function(it)
    local parts = { "\n_@" }
    table.insert(parts, it.name)
    table.insert(parts, "_ — ")
    table.insert(parts, concat_description(it.text, nil, true))

    return table.concat(parts, "")
  end, tags) or {}, "\n")
end

local make_text_edits = function(code_actions)
  if not code_actions then
    return nil
  end

  local text_edits = {}

  for _, action in ipairs(code_actions) do
    for _, changes_set in ipairs(action.changes) do
      for _, change in ipairs(changes_set.textChanges) do
        table.insert(text_edits, {
          newText = change.newText,
          range = utils.convert_tsserver_range_to_lsp(change),
        })
      end
    end
  end

  return text_edits
end

local completion_response_handler = function(_, body, request_params)
  if body and body[1] then
    local details = body[1]

    table.insert(details.documentation, { text = make_tags(details.tags) })
    return vim.tbl_extend("force", request_params, {
      detail = concat_description(details.displayParts),
      documentation = {
        kind = constants.MarkupKind.Markdown,
        value = concat_description(details.documentation, "\n"),
      },
      additionalTextEdits = make_text_edits(details.codeActions),
      -- INFO: there is also `command` prop but I don't know there is usecase for that here,
      -- or neovim even handle than for now i skip this
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
