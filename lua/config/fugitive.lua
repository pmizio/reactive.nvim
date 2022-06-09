local map = vim.keymap.set
local fn = vim.fn

-- TODO: convert viml to lua
local function toggle_fugitive_status()
  if fn.buflisted(fn.bufname ".git/index") ~= 0 then
    vim.cmd ":bd .git/index"
  else
    vim.cmd ":G"
  end
end

map("n", "<leader>gs", toggle_fugitive_status)
