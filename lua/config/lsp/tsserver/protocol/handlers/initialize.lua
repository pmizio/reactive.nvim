local constants = require "config.lsp.tsserver.protocol.constants"
local capabilities = require "config.lsp.tsserver.capabilities"

local configure = function()
  return {
    command = constants.CommandTypes.Configure,
    arguments = {
      hostInfo = "neovim",
      -- TODO: expose as configuration
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
        quotePreference = "auto",
        importModuleSpecifierEnding = "auto",
        jsxAttributeCompletionStyle = "auto",
        allowTextChangesInNewFiles = true,
        providePrefixAndSuffixTextForRename = true,
        allowRenameOfImportPath = true,
        includeAutomaticOptionalChainCompletions = true,
        provideRefactorNotApplicableReason = true,
        generateReturnInDocTemplate = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
        autoImportFileExcludePatterns = {},
        useLabelDetailsInCompletionEntries = true,
        allowIncompleteCompletions = true,
        displayPartsForJSDoc = true,
        includeInlayParameterNameHints = "none",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
      watchOptions = {},
    },
  }
end

local initialize_request_handler = function()
  -- TODO: in here we need get this options from tsconfig.json
  return {
    command = constants.CommandTypes.CompilerOptionsForInferredProjects,
    arguments = {
      options = {
        module = "ESNext",
        moduleResolution = "Node",
        target = "ES2020",
        jsx = "react",
        strictNullChecks = true,
        strictFunctionTypes = true,
        sourceMap = true,
        allowJs = true,
        allowSyntheticDefaultImports = true,
        allowNonTsExtensions = true,
        resolveJsonModule = true,
      },
    },
  }
end

local initialize_response_handler = function()
  return { capabilities = capabilities }
end

return {
  configure = configure,
  request = { method = constants.LspMethods.Initialize, handler = initialize_request_handler },
  response = {
    method = constants.CommandTypes.CompilerOptionsForInferredProjects,
    handler = initialize_response_handler,
  },
}
