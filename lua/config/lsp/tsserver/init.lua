local log = require "vim.lsp.log"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local rpc = require "config.lsp.tsserver.rpc"

local NAME = "tsserver_nvim"

local M = {}

M.setup = function(on_attach)
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
      root_dir = lspconfig.util.root_pattern(
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
        ".git"
      ),
    },
  }

  lspconfig[NAME].setup {
    on_attach = on_attach,
  }
end

return M
