local constants = require "config.lsp.tsserver.protocol.constants"
local config = require "config.lsp.tsserver.config"
local make_capabilities = require "config.lsp.tsserver.capabilities"

local configure = function()
  return {
    command = constants.CommandTypes.Configure,
    arguments = {
      hostInfo = "neovim",
      -- TODO: expose as configuration
      preferences = {
        providePrefixAndSuffixTextForRename = true,
        allowRenameOfImportPath = true,
        includePackageJsonAutoImports = "auto",
      },
      plugins = {},
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
  return { capabilities = make_capabilities(config) }
end

return {
  configure = configure,
  request = { method = constants.LspMethods.Initialize, handler = initialize_request_handler },
  response = {
    method = constants.CommandTypes.CompilerOptionsForInferredProjects,
    handler = initialize_response_handler,
  },
}
