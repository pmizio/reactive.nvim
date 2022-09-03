local constants = require "config.lsp.tsserver.protocol.constants"

local EventEmitter = {
  listeners = {},
  update_open_tracker = {},
}

function EventEmitter:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  return o
end

function EventEmitter:add_listener(events, listener)
  events = type(events) == "string" and { events } or events

  for _, event in pairs(events) do
    local event_listeners = self.listeners[event]

    if not event_listeners then
      self.listeners[event] = {}
      table.insert(self.listeners[event], listener)
    elseif not vim.tbl_contains(event_listeners, listener) then
      table.insert(event_listeners, listener)
    end
  end
end

function EventEmitter:track_update_notification(method, seq)
  if method == constants.LspMethods.DidOpen or method == constants.LspMethods.DidChange then
    self.update_open_tracker[seq] = true
  end
end

function EventEmitter:_call_listeners(event, response)
  local listeners = self.listeners[event]

  if not listeners then
    return
  end

  for _, listener in pairs(listeners) do
    listener(response)
  end
end

function EventEmitter:process_tsserver_response(response)
  local seq = response.request_seq
  if response.command == constants.CommandTypes.UpdateOpen and self.update_open_tracker[seq] then
    self.update_open_tracker[seq] = nil
    self:_call_listeners(response.command, response)
    return
  end

  if response.type == "event" then
    self:_call_listeners(response.event, response)
  end
end

return EventEmitter
