local schedule_wrap = vim.schedule_wrap

local log = require "vim.lsp.log"
local constants = require "config.lsp.tsserver.protocol.constants"
local TsserverRpc = require "config.lsp.tsserver.tsserver_rpc"
local initialize = require "config.lsp.tsserver.protocol.handlers.initialize"
local request_handlers = require("config.lsp.tsserver.protocol").request_handlers
local response_handlers = require("config.lsp.tsserver.protocol").response_handlers

--- @class TsserverInstance
--- @field rpc TsserverRpc|nil
--- @field seq number
--- @field pending number|nil
--- @field message_queue table
--- @field request_args table

--- @class TsserverInstance
local TsserverInstance = {
  seq = 0,
  pending = nil,
  message_queue = {},
  request_args = {},
}

--- @param path table Plenary path object
--- @return TsserverInstance
function TsserverInstance:new(path)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.rpc = TsserverRpc:new(path)
  if self.rpc:spawn() then
    self.rpc:on_message(function(message)
      self:handle_response(message)
    end)
  end

  return o
end

--- @private
--- @param message string
function TsserverInstance:handle_response(message)
  local ok, response = pcall(vim.json.decode, message, { luanil = { object = true } })
  if not ok then
    log.error("Invalid json: ", response)
    return
  end
  log.warn(">>>>>" .. message)

  local handler = response_handlers[response.command]
  local request_seq = response.request_seq
  local request_args = self.request_args[request_seq]

  if request_args then
    if request_args.notify_reply_callback then
      request_args.notify_reply_callback(request_seq)
    end

    local callback = request_args.callback

    if response.type == "response" and handler and callback then
      local status, result = pcall(
        handler,
        response.command,
        response.body or response,
        request_args.params
      )

      if not status then
        callback(result, response)
      end

      if result then
        callback(nil, result)
      end
    end
  end

  if self.pending == request_seq then
    self.pending = nil
  end

  if request_args then
    self.request_args[request_seq] = nil
  end

  while not self.pending and #self.message_queue > 0 do
    local args = self:dequeue()

    if args then
      self:handle_request(
        args.method,
        args.params,
        args.callback,
        args.notify_reply_callback,
        args.is_async
      )
    end
  end
end

--- @private
--- @param message table
--- @param is_async boolean|nil
--- @return number
function TsserverInstance:write(message, is_async)
  local full_message = vim.tbl_extend("force", {
    seq = self.seq,
    type = "request",
  }, message)

  self.rpc:write(full_message)

  local tmp_seq = self.seq

  self.seq = self.seq + 1

  if not is_async then
    self.pending = tmp_seq
  end

  return tmp_seq
end

--- @private
--- @param message table
function TsserverInstance:enqueue(message)
  table.insert(self.message_queue, message)
end

--- @private
--- @return table
function TsserverInstance:dequeue()
  local message = self.message_queue[1]

  if message then
    table.remove(self.message_queue, 1)
  end

  return message
end

--- @private
--- @param method string
--- @param params table
--- @param callback function
--- @param notify_reply_callback function
--- @param is_async boolean|nil
function TsserverInstance:handle_request(method, params, callback, notify_reply_callback, is_async)
  local tsserver_request = request_handlers[method]

  if tsserver_request then
    local scheduled_callback = callback and schedule_wrap(callback) or nil
    local scheduled_notify_reply_callback = notify_reply_callback
        and schedule_wrap(notify_reply_callback)
      or nil

    local args = {
      method = method,
      params = params or {},
      callback = scheduled_callback,
      notify_reply_callback = scheduled_notify_reply_callback,
      is_async = is_async,
    }

    if pending then
      self:enqueue(args)
    else
      local message = tsserver_request(
        method,
        params,
        scheduled_callback,
        scheduled_notify_reply_callback
      )

      self.request_args[self.seq] = args
      self:write(message, is_async)
    end
  end
end

---@returns Methods:
--- - `notify()` |vim.lsp.rpc.notify()|
--- - `request()` |vim.lsp.rpc.request()|
--- - `is_closing()` returns a boolean indicating if the RPC is closing.
--- - `terminate()` terminates the RPC client.
function TsserverInstance:get_lsp_interface()
  return {
    request = function(method, params, callback, notify_reply_callback)
      P("request: " .. method)
      if method == constants.LspMethods.Initialize then
        self:write(initialize.configure())
      end

      self:handle_request(method, params, callback, notify_reply_callback)
    end,
    notify = function(method, params, ...)
      P("notify: " .. method)
      self:handle_request(method, params, ...)
    end,
    is_closing = function()
      return self.rpc:is_closing()
    end,
    terminate = function()
      self.rpc:terminate()
    end,
  }
end

return TsserverInstance
