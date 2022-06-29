local fn = vim.fn

vim.api.nvim_create_user_command("Wqa", "wa | qa", { force = true })

function ReloadConfig()
  local config_prefix = fn.fnamemodify(vim.env.MYVIMRC, ":p:h") .. "/lua/"
  local lua_dirs = fn.glob(config_prefix .. "**", 0, 1)

  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(fn.fnamemodify(dir, ":r"), config_prefix, "")
    require("plenary.reload").reload_module(dir, true)
    pcall(require, dir)
  end
  dofile(vim.env.MYVIMRC)
end

vim.api.nvim_create_user_command("R", ReloadConfig, { force = true })
