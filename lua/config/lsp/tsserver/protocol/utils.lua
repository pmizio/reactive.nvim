local c = require "config.lsp.tsserver.protocol.constants"

local M = {}

local language_id_to_script_kind = {
  typescript = c.ScriptKindName.TS,
  typescriptreact = c.ScriptKindName.TSX,
  javascript = c.ScriptKindName.JS,
  javascriptreact = c.ScriptKindName.JSX,
}

local symbol_kind_map = {
  [c.ScriptElementKind.moduleElement] = c.SymbolKind.Module,
  [c.ScriptElementKind.classElement] = c.SymbolKind.Class,
  [c.ScriptElementKind.localClassElement] = c.SymbolKind.Class,
  [c.ScriptElementKind.interfaceElement] = c.SymbolKind.Interface,
  [c.ScriptElementKind.typeElement] = c.SymbolKind.TypeParameter,
  [c.ScriptElementKind.enumElement] = c.SymbolKind.Enum,
  [c.ScriptElementKind.enumMemberElement] = c.SymbolKind.EnumMember,
  [c.ScriptElementKind.variableElement] = c.SymbolKind.Variable,
  [c.ScriptElementKind.localVariableElement] = c.SymbolKind.Variable,
  [c.ScriptElementKind.functionElement] = c.SymbolKind.Function,
  [c.ScriptElementKind.localFunctionElement] = c.SymbolKind.Function,
  [c.ScriptElementKind.memberFunctionElement] = c.SymbolKind.Method,
  [c.ScriptElementKind.memberGetAccessorElement] = c.SymbolKind.Method,
  [c.ScriptElementKind.memberSetAccessorElement] = c.SymbolKind.Method,
  [c.ScriptElementKind.memberVariableElement] = c.SymbolKind.Property,
  [c.ScriptElementKind.constructorImplementationElement] = c.SymbolKind.Constructor,
  [c.ScriptElementKind.constructSignatureElement] = c.SymbolKind.Constructor,
  [c.ScriptElementKind.parameterElement] = c.SymbolKind.Variable,
  [c.ScriptElementKind.typeParameterElement] = c.SymbolKind.TypeParameter,
  [c.ScriptElementKind.constElement] = c.SymbolKind.Constant,
  [c.ScriptElementKind.letElement] = c.SymbolKind.Variable,
  [c.ScriptElementKind.externalModuleName] = c.SymbolKind.Module,
  [c.ScriptElementKind.jsxAttribute] = c.SymbolKind.Property,
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

M.get_lsp_symbol_kind = function(script_element_kind)
  local kind = symbol_kind_map[script_element_kind]

  if kind then
    return kind
  end

  vim.notify(
    "Cannot find matching LSP script kind for: " .. script_element_kind,
    vim.log.levels.ERROR
  )
end

return M
