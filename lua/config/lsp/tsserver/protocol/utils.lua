local constants = require "config.lsp.tsserver.protocol.constants"

local M = {}

local language_id_to_script_kind = {
  typescript = constants.ScriptKindName.TS,
  typescriptreact = constants.ScriptKindName.TSX,
  javascript = constants.ScriptKindName.JS,
  javascriptreact = constants.ScriptKindName.JSX,
}

M.get_text_document_script_kind = function(text_document)
  return language_id_to_script_kind[text_document.languageId]
end

M.convert_lsp_position_to_tsserver = function(position)
  return {
    line = position.line + 1,
    offset = position.character + 1,
  }
end

M.convert_lsp_range_to_tsserver = function(range)
  return {
    start = M.convert_lsp_position_to_tsserver(range.start),
    ["end"] = M.convert_lsp_position_to_tsserver(range["end"]),
  }
end

M.convert_tsserver_position_to_lsp = function(position)
  return {
    line = position.line - 1,
    character = position.offset - 1,
  }
end

M.convert_tsserver_range_to_lsp = function(range)
  return {
    start = M.convert_tsserver_position_to_lsp(range.start),
    ["end"] = M.convert_tsserver_position_to_lsp(range["end"]),
  }
end

M.tsserver_docs_to_plain_text = function(parts, delim, tag_formatting)
  delim = delim or ""

  if type(parts) == "string" then
    return parts
  end

  return table.concat(vim.tbl_map(function(it)
    if tag_formatting and it.kind == "parameterName" then
      return "`" .. it.text .. "`"
    end

    return it.text
  end, parts) or {}, delim)
end

M.tsserver_make_tags = function(tags)
  return table.concat(vim.tbl_map(function(it)
    local parts = { "\n_@" }
    table.insert(parts, it.name)
    table.insert(parts, "_ — ")
    table.insert(parts, M.tsserver_docs_to_plain_text(it.text, nil, true))

    return table.concat(parts, "")
  end, tags) or {}, "\n")
end

return M
