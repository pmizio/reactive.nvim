local log = require "vim.lsp.log"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"
local rpc = require "config.lsp.tsserver.rpc"
local plugin_config = require "config.lsp.tsserver.config"

local NAME = "tsserver_nvim"

local M = {}

M.setup = function(config)
  local settings = config.settings or {}

  plugin_config.load_and_validate(settings)

  configs[NAME] = {
    default_config = {
      cmd = function(...)
        local ok, tsserver_rpc = pcall(rpc.start, NAME, ...)
        if ok then
          return tsserver_rpc
        else
          log.error(tsserver_rpc)
        end

        return nil
      end,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      -- stealed from:
      -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
      root_dir = function(fname)
        return util.root_pattern "tsconfig.json"(fname)
          or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
      end,
    },
  }

  lspconfig[NAME].setup(config)
end

return M
