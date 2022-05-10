local util = require "lspconfig.util"

local M = {}

local PACKAGE_JSON = "package.json"

local PRETTIER_CONFIG = {
  ".prettierrc",
  ".prettierrc.json",
  "prettier.config.js",
  ".prettierrc.js",
  ".prettierrc.yml",
  ".prettierrc.yaml",
  ".prettierrc.json5",
  ".prettierrc.cjs",
  "prettier.config.cjs",
  ".prettierrc.toml",
}

function M.has_prettier_config()
  local file_path = vim.api.nvim_buf_get_name(0)

  if file_path == "" or file_path == nil then
    file_path = vim.fn.getcwd()
  end

  local package_json = util.root_pattern(PACKAGE_JSON)(file_path)
  if package_json ~= nil then
    local content = table.concat(vim.fn.readfile(package_json .. "/" .. PACKAGE_JSON, "\n"))
    local err, json_content = pcall(vim.json.decode, content)

    if err and json_content.prettier ~= nil then
      return true
    end
  end

  for _, c in pairs(PRETTIER_CONFIG) do
    if util.root_pattern(c)(file_path) ~= nil then
      return true
    end
  end

  return false
end

return M
