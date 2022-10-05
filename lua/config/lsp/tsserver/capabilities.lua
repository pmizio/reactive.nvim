local lspProtocol = require "vim.lsp.protocol"
local constants = require "config.lsp.tsserver.protocol.constants"

local capabilities = {
  textDocumentSync = lspProtocol.TextDocumentSyncKind.Incremental,
  renameProvider = {
    -- tsserver doesn't have something like textDocument/prepareRename
    prepareProvider = false,
  },
  completionProvider = {
    resolveProvider = true,
    triggerCharacters = {
      ".",
      '"',
      "'",
      "`",
      "/",
      "@",
      "<",
    },
  },
  hoverProvider = true,
  definitionProvider = true,
  typeDefinitionProvider = true,
  declarationProvider = false,
  implementationProvider = true,
  referencesProvider = true,
  documentSymbolProvider = true,
  documentHighlightProvider = true,
  signatureHelpProvider = {
    triggerCharacters = { "(", ",", "<" },
    retriggerCharacters = { ")" },
  },
  codeActionProvider = {
    codeActionKinds = {
      constants.CodeActionKind.Empty,
      constants.CodeActionKind.QuickFix,
      constants.CodeActionKind.Refactor,
      constants.CodeActionKind.RefactorExtract,
      constants.CodeActionKind.RefactorInline,
      constants.CodeActionKind.RefactorRewrite,
      constants.CodeActionKind.Source,
      constants.CodeActionKind.SourceOrganizeImports,
    },
    resolveProvider = true,
  },
}

return capabilities
