local constants = require "config.lsp.tsserver.protocol.constants"
local handlers = require "config.lsp.tsserver.protocol.handlers"
local make_protocol_handlers = require "config.lsp.tsserver.protocol.handlers"

local M = {}

M.constants = constants
M.handlers = handlers

M.initialize = require "config.lsp.tsserver.protocol.initialize"

M.request_handlers, M.response_handlers = make_protocol_handlers()

return M
