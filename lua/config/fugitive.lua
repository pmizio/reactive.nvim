local m = require "config.utils.map"
local fn = vim.fn
local one_au = require("config.utils").create_onetime_autocmd

-- TODO: convert viml to lua
local function toggle_fugitive_status()
  if fn.buflisted(fn.bufname ".git/index") ~= 0 then
    vim.cmd ":bd .git/index"
  else
    vim.cmd ":G"
  end
end

m.nmap("<leader>gs", toggle_fugitive_status)

one_au("FileType", {
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
