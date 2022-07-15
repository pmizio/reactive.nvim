local other = require "other-nvim"
local m = require "config.utils.map"
local list = require "config.utils.list"

local function ts_tests(suffix)
  local test_ext = string.format(".%s.[tj]sx?", suffix)

  return {
    {
      pattern = "/(.*)/(.*).([tj]sx?)$",
      target = {
        {
          target = "/%1/__tests__/%2." .. suffix .. ".%3",
          context = "test",
        },
        {
          target = "/%1/%2." .. suffix .. ".%3",
          context = "test",
        },
      },
    },
    {
      pattern = "/(.*)/__tests__/(.*)." .. suffix .. ".([tj]sx?)$",
      target = "/%1/%2.%3",
      context = "test",
    },
    {
      pattern = "/(.*)/(.*)." .. test_ext .. ".([tj]sx?)$",
      target = "/%1/%2.%3",
      context = "test",
    },
  }
end

other.setup {
  mappings = list.extend({}, ts_tests "spec", ts_tests "test"),
}

m.nmap("<leader>gt", function()
  other.open "test"
end)
