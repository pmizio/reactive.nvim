local fn = vim.fn
local config_autocmd = require("pmizio.utils").config_autocmd

config_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)[1]

    if content ~= "" and content:find "^Merge branch" == nil then
      return
    end

    local branch = fn.system("git branch --show-current"):match "/?([%u%d]+-%d+)-?"

    if branch then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { branch .. " | " })
      vim.cmd ":startinsert!"
    end
  end,
})

require("gitsigns").setup {}
