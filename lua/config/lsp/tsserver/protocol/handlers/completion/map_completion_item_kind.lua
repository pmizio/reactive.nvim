local c = require "config.lsp.tsserver.protocol.constants"

local tsserver_kind_to_lsp_kind = {
  [c.ScriptElementKind.unknown] = c.CompletionItemKind.Text,
  [c.ScriptElementKind.warning] = c.CompletionItemKind.Text,
  [c.ScriptElementKind.keyword] = c.CompletionItemKind.Keyword,
  [c.ScriptElementKind.scriptElement] = c.CompletionItemKind.Module,
  [c.ScriptElementKind.moduleElement] = c.CompletionItemKind.Module,
  [c.ScriptElementKind.classElement] = c.CompletionItemKind.Class,
  [c.ScriptElementKind.localClassElement] = c.CompletionItemKind.Class,
  [c.ScriptElementKind.interfaceElement] = c.CompletionItemKind.Interface,
  [c.ScriptElementKind.typeElement] = c.CompletionItemKind.TypeParameter,
  [c.ScriptElementKind.enumElement] = c.CompletionItemKind.Enum,
  [c.ScriptElementKind.enumMemberElement] = c.CompletionItemKind.EnumMember,
  [c.ScriptElementKind.variableElement] = c.CompletionItemKind.Variable,
  [c.ScriptElementKind.localVariableElement] = c.CompletionItemKind.Variable,
  [c.ScriptElementKind.functionElement] = c.CompletionItemKind.Function,
  [c.ScriptElementKind.localFunctionElement] = c.CompletionItemKind.Function,
  [c.ScriptElementKind.memberFunctionElement] = c.CompletionItemKind.Method,
  [c.ScriptElementKind.memberGetAccessorElement] = c.CompletionItemKind.Property,
  [c.ScriptElementKind.memberSetAccessorElement] = c.CompletionItemKind.Property,
  [c.ScriptElementKind.memberVariableElement] = c.CompletionItemKind.Property,
  [c.ScriptElementKind.constructorImplementationElement] = c.CompletionItemKind.Constructor,
  [c.ScriptElementKind.callSignatureElement] = c.CompletionItemKind.Method,
  [c.ScriptElementKind.indexSignatureElement] = c.CompletionItemKind.Method,
  [c.ScriptElementKind.constructSignatureElement] = c.CompletionItemKind.Method,
  [c.ScriptElementKind.parameterElement] = c.CompletionItemKind.Field,
  [c.ScriptElementKind.typeParameterElement] = c.CompletionItemKind.TypeParameter,
  [c.ScriptElementKind.primitiveType] = c.CompletionItemKind.Keyword,
  [c.ScriptElementKind.label] = c.CompletionItemKind.Keyword,
  [c.ScriptElementKind.alias] = c.CompletionItemKind.Variable,
  [c.ScriptElementKind.constElement] = c.CompletionItemKind.Constant,
  [c.ScriptElementKind.letElement] = c.CompletionItemKind.Variable,
  [c.ScriptElementKind.directory] = c.CompletionItemKind.File,
  [c.ScriptElementKind.externalModuleName] = c.CompletionItemKind.Module,
  [c.ScriptElementKind.jsxAttribute] = c.CompletionItemKind.Variable,
  [c.ScriptElementKind.string] = c.CompletionItemKind.Constant,
  [c.ScriptElementKind.link] = c.CompletionItemKind.Text,
  [c.ScriptElementKind.linkName] = c.CompletionItemKind.Text,
  [c.ScriptElementKind.linkText] = c.CompletionItemKind.Text,
}

local map_completion_item_kind = function(script_element_kind)
  local kind = tsserver_kind_to_lsp_kind[script_element_kind]

  if kind then
    return kind
  end

  return c.ScriptElementKind.Text
end

return map_completion_item_kind
