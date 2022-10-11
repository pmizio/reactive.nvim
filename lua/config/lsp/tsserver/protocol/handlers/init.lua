local make_protocol_handlers = function()
  local request_handlers, response_handlers = {}, {}

  local assign_handlers = function(config)
    local request = config.request
    local response = config.response

    request_handlers[request.method] = request.handler

    if response then
      if vim.tbl_islist(response) then
        for _, it in ipairs(response) do
          response_handlers[it.method] = it.handler
        end
      else
        response_handlers[response.method] = response.handler
      end
    end
  end

  assign_handlers(require "config.lsp.tsserver.protocol.handlers.initialize")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.did_open")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.did_close")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.did_change")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.rename")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.completion")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.completion.resolve")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.hover")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.definition")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.type_definition")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.implementation")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.references")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.document_symbol")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.document_highlight")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.code_action_resolve")
  assign_handlers(require "config.lsp.tsserver.protocol.handlers.signature_help")

  assign_handlers(require "config.lsp.tsserver.protocol.handlers.shutdown")

  return request_handlers, response_handlers
end

return make_protocol_handlers
