local configs = require "lspconfig.configs"
local clangd_config = require "lspconfig.server_configurations.clangd"
local util = require "lspconfig.util"

configs.esp_clangd = vim.tbl_extend("force", {}, clangd_config)

local default_config = configs.esp_clangd.document_config.default_config

default_config.cmd = {
  os.getenv "HOME"
    .. "/.espressif/tools/xtensa-clang/14.0.0-38679f0333/xtensa-esp32-elf-clang/bin/clangd",
}

default_config.root_dir = function(fname)
  return util.root_pattern "sdkconfig"(fname)
end
