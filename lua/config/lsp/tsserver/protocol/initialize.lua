local constants = require "config.lsp.tsserver.protocol.constants"
local capabilities = require "config.lsp.tsserver.capabilities"

local M = {}

---@private
M[constants.CommandTypes.Configure] = nil
---@private
M[constants.CommandTypes.CompilerOptionsForInferredProjects] = nil
---@private
M._encode_and_send = function(arg) end
---@private
M._callback = function(arg1, arg2) end

M.handle_request = function(encode_and_send, callback)
  M._encode_and_send = encode_and_send
  M._callback = callback
  encode_and_send {
    command = constants.CommandTypes.Configure,
    arguments = {
      hostInfo = "neovim",
      preferences = {
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

M.handle_response = function(response)
  if response.type == "response" and response.command == constants.CommandTypes.Configure then
    if not response.success then
      vim.notify("Initial configuration of tsserver failed!", vim.log.levels.ERROR)
      return false
    end

    -- TODO: in here we need get this options from tsconfig.json
    M._encode_and_send {
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
    return false
  elseif
    response.type == "response"
    and response.command == constants.CommandTypes.CompilerOptionsForInferredProjects
  then
    if not response.success then
      vim.notify("Setup of typescript compiler options failed!", vim.log.levels.ERROR)
      return false
    end

    vim.schedule(function()
      M._callback(nil, { capabilities = capabilities })
    end)
  end

  return true
end

return M
