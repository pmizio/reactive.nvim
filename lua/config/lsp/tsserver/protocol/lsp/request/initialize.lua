local constants = require("config.lsp.tsserver.protocol").constants
local capabilities = require "config.lsp.tsserver.capabilities"

return function(encode_and_send, _, _, callback)
  encode_and_send {
    command = constants.CommandTypes.Configure,
    arguments = {
      hostInfo = "neovim",
      preferences = {
        providePrefixAndSuffixTextForRename = true,
        allowRenameOfImportPath = true,
        includePackageJsonAutoImports = "auto",
      },
      watchOptions = {},
    },
  }

  -- TODO: in here we need get this options from tsconfig.json
  encode_and_send {
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

  callback(nil, { capabilities = capabilities })

  return true
end
