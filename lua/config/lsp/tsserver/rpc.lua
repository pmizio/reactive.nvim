local api = vim.api
local uv = vim.loop
local schedule_wrap = vim.schedule_wrap
local log = require "vim.lsp.log"
local util = require "lspconfig.util"
local configs = require "lspconfig.configs"
local Path = require "plenary.path"

local setup_requests = require "config.lsp.tsserver.protocol.lsp.request"
local handlers = require("config.lsp.tsserver.protocol").handlers

local is_win = uv.os_uname().version:find "Windows"

local M = {}

---@param server_name string
M.setup = function(server_name)
  local rpc = require "vim.lsp.rpc"

  if rpc._setup_tsserver_nvim then
    return
  end

  local nvim_rpc_start = rpc.start

  rpc.start = function(cmd, cmd_args, dispatchers, ...)
    if cmd == server_name then
      return M.start(server_name, dispatchers)
    end

    return nvim_rpc_start(cmd, cmd_args, dispatchers, ...)
  end

  rpc._setup_tsserver_nvim = true
end

---@param server_name string
M.start = function(server_name, dispatchers)
  local config = configs[server_name]
  local bufnr = api.nvim_get_current_buf()
  local bufname = api.nvim_buf_get_name(bufnr)
  if not util.bufname_valid(bufname) then
    return
  end

  local root_dir = config.get_root_dir(util.path.sanitize(bufname), bufnr)
  local tsserver_path = Path:new(root_dir, "node_modules", "typescript", "lib", "tsserver.js")
  if not tsserver_path:exists() then
    return
  end

  local seq = 0
  local request_params = {}
  local callbacks = {}
  local notify_reply_callbacks = {}

  local stdin = uv.new_pipe(false)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local spawn_params = {
    args = { tsserver_path:absolute(), "--stdio" },
    stdio = { stdin, stdout, stderr },
    detached = not is_win,
  }

  local close_pipes = function()
    stdin:close()
    stdout:close()
    stderr:close()
  end

  local handle, pid = uv.spawn("node", spawn_params, close_pipes)
  if handle == nil then
    close_pipes()
    local msg = "Spawning language server with cmd: `tsserver` failed"
    if string.match(pid, "ENOENT") then
      msg = msg
        .. ". The language server is either not installed, missing from PATH, or not executable."
    else
      msg = msg .. string.format(" with error message: %s", pid)
    end
    vim.notify(msg, vim.log.levels.WARN)
    return
  end

  --- tsserver send only one header - Content-Length so we can just hardcode length of header name:
  --- Content-Length:_ = 16, but lua is 1 based so: 16 + 1 = 17
  ---
  ---@param header_string string
  local function parse_content_length(header_string)
    return tonumber(header_string:sub(17))
  end

  local function handle_body(body_string)
    local ok, response = pcall(vim.json.decode, body_string, { luanil = { object = true } })
    if not ok then
      log.error("Invalid json: ", response)
      return nil
    end

    local handler = handlers[response.command]
    local request_seq = response.request_seq
    local callback = callbacks[request_seq]
    local notify_reply_callback = notify_reply_callbacks[request_seq]

    if notify_reply_callback then
      notify_reply_callback(request_seq)
      notify_reply_callbacks[request_seq] = nil
    end

    if response.type == "response" and handler and callback then
      local status, result = pcall(
        handler,
        response.command,
        response.body or response,
        request_params[request_seq]
      )

      request_params[request_seq] = nil

      if not status then
        callback(result, response)
        callbacks[request_seq] = nil
        return
      end

      if result then
        callback(nil, result)
      end

      -- in case of unhandled request cleanup it's mess
      if request_seq then
        callbacks[request_seq] = nil
      end
    end
  end

  ---@param chunk string
  local parse_response = function(chunk)
    log.warn(chunk)

    local header_end, body_start = chunk:find("\r\n\r\n", 1, true)
    if header_end then
      local header = chunk:sub(1, header_end - 1)
      local body = chunk:sub(body_start + 1)
      local body_length = parse_content_length(header)
      log.warn(">>>>>" .. body_length)
      log.warn(">>>>>" .. body)
      log.warn(">>>>>" .. #body)
      if body_length == #body then
        handle_body(body)
      end
    end
  end

  stdout:read_start(function(err, chunk)
    if err then
      -- TODO: any error handling
      P "error on stdout"
      return
    end

    -- just skip empty chunks
    if not chunk then
      return
    end

    parse_response(chunk)
  end)

  stderr:read_start(function(_, chunk)
    if chunk then
      local _ = log.error() and log.error("rpc", server_name, "stderr", chunk)
    end
  end)

  ---@param message table
  local encode_and_send = function(message)
    local full_message = vim.tbl_extend("force", {
      seq = seq,
      type = "request",
    }, message)
    local as_json = vim.json.encode(full_message)

    stdin:write(as_json)
    -- this flush request to tsserver
    stdin:write "\r\n"

    seq = seq + 1
  end

  local requests = setup_requests(encode_and_send)

  return {
    request = function(method, params, callback, notify_reply_callback)
      P("request: " .. method)

      local tsserver_request = requests[method]

      if tsserver_request then
        request_params[seq] = params

        if callback then
          callbacks[seq] = schedule_wrap(callback)
        end

        if notify_reply_callback then
          notify_reply_callbacks[seq] = schedule_wrap(notify_reply_callback)
        end

        return tsserver_request(method, params, callback, notify_reply_callbacks)
      end

      return false
    end,
    notify = function(method, ...)
      P("notify: " .. method)
      local tsserver_request = requests[method]

      if tsserver_request then
        return tsserver_request(method, ...)
      end

      return false
    end,
    pid = pid,
    handle = handle,
  }
end

return M
