local m = require "config.utils.map"
local fn = vim.fn
local one_au = require("config.utils").create_onetime_autocmd

-- TODO: convert viml to lua
local function toggle_fugitive_status()
  local fugitive_buf = vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_get_name(bufnr):find "%.git/.*/?index"
  end, vim.api.nvim_list_bufs())[1]

  if fugitive_buf ~= nil then
    vim.api.nvim_buf_delete(fugitive_buf, { force = true })
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

require("gitsigns").setup {}
