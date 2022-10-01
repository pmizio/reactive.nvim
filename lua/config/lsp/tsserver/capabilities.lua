local lspProtocol = require "vim.lsp.protocol"

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
  signatureHelpProvider = {
    triggerCharacters = { "(", ",", "<" },
    retriggerCharacters = { ")" },
  },
}

return capabilities
