local api = vim.api

local constants = require "config.lsp.tsserver.protocol.constants"

local M = {}

--- @param params table
--- @param callback function
--- @param notify_reply_callback function
M.handle_command = function(params, callback, notify_reply_callback)
  vim.schedule(function()
    -- TODO: we maintain are own requests id's IDK we shoudld handle them?
    notify_reply_callback(-1)
    callback(nil, nil)

    local command_handler = M[params.command]

    if command_handler then
      command_handler(params)
    end
  end)
end

--- @param params table
M[constants.InternalCommands.InvokeAdditionalRename] = function(params)
  local pos = params.arguments[2]

  api.nvim_win_set_cursor(0, { pos.line, pos.offset - 1 })

  -- INFO: wait just a bit to cursor move and then call rename
  vim.defer_fn(function()
    vim.lsp.buf.rename()
  end, 100)
end

return M
