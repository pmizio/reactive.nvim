local constants = require "config.lsp.tsserver.protocol.constants"

local handlers = {
  [constants.CommandTypes.Configure] = require "config.lsp.tsserver.protocol.handlers.possible_error",
  [constants.CommandTypes.CompilerOptionsForInferredProjects] = require "config.lsp.tsserver.protocol.handlers.possible_error",
  [constants.CommandTypes.Rename] = require "config.lsp.tsserver.protocol.handlers.rename",
}

return handlers
