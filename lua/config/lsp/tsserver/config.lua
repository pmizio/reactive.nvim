local M = {}

--- @private
local __store = {}

M.COMPOSITE_MODES = {
  SINGLE = "single",
  SEPARATE_DIAGNOSTIC = "separate_diagnostic",
}

vim.tbl_add_reverse_lookup(M.COMPOSITE_MODES)

M.PUBLISH_DIAGNOSTIC_ON = {
  CHANGE = "change",
  INSERT_LEAVE = "insert_leave",
}

vim.tbl_add_reverse_lookup(M.PUBLISH_DIAGNOSTIC_ON)

--- @param settings table
M.load_and_validate = function(settings)
  --- @param enum table
  --- @param key string
  --- @param default_value any
  local function validate_enum(enum, key, default_value)
    local value = settings[key]

    if type(value) ~= "nil" and not enum[value] then
      local modes = table.concat(vim.tbl_values(enum), ", ")

      assert(false, key .. " mode should be one of: " .. modes)
    end

    if type(value) == "nil" and default_value then
      settings[key] = default_value
    end
  end

  vim.validate {
    settings = { settings, "table" },
  }

  validate_enum(M.COMPOSITE_MODES, "composite_mode", M.COMPOSITE_MODES.SINGLE)
  validate_enum(
    M.PUBLISH_DIAGNOSTIC_ON,
    "publish_diagnostic_on",
    M.PUBLISH_DIAGNOSTIC_ON.INSERT_LEAVE
  )

  __store = vim.tbl_deep_extend("force", __store, settings)
end

setmetatable(M, {
  __index = function(_, key)
    return __store[key]
  end,
})

return M
