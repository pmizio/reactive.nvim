return function(encode_and_send)
  local wrap_handler = function(handler)
    return function(...)
      return handler(encode_and_send, ...)
    end
  end

  return {
    ["initialize"] = wrap_handler(require "config.lsp.tsserver.protocol.lsp.request.initialize"),
    ["textDocument/didOpen"] = wrap_handler(
      require "config.lsp.tsserver.protocol.lsp.request.did_open"
    ),
    ["textDocument/didChange"] = wrap_handler(
      require "config.lsp.tsserver.protocol.lsp.request.did_change"
    ),
    ["textDocument/rename"] = wrap_handler(
      require "config.lsp.tsserver.protocol.lsp.request.rename"
    ),
  }
end
