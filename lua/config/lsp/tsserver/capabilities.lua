local lspProtocol = require "vim.lsp.protocol"

local capabilities = {
  textDocumentSync = lspProtocol.TextDocumentSyncKind.Incremental,
  renameProvider = {
    -- tsserver doesn't have something like textDocument/prepareRename
    prepareProvider = false,
  },
  completionProvider = {
    resolveProvider = false,
    triggerCharacters = {
      ".",
      '"',
      "'",
      "`",
      "/",
      "@",
      "<",

      -- Emmet
      ">",
      "*",
      "#",
      "$",
      "+",
      "^",
      "(",
      "[",
      "@",
      "-",
    },
  },
}

return capabilities
