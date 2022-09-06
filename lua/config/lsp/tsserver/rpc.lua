local api = vim.api
local util = require "lspconfig.util"
local configs = require "lspconfig.configs"
local Path = require "plenary.path"

local TsserverInstance = require "config.lsp.tsserver.tsserver_instance"

local M = {}

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
    return {}
  end

  local tsserver = TsserverInstance:new(tsserver_path)

  return tsserver:get_lsp_interface()
end

return M
