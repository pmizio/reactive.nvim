local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local rpc = require "config.lsp.tsserver.rpc"

local NAME = "tsserver_nvim"

local M = {}

M.setup = function(on_attach)
  rpc.setup(NAME)

  configs[NAME] = {
    default_config = {
      cmd = { NAME },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    },
  }

  lspconfig[NAME].setup {
    on_attach = on_attach,
  }
end

return M
