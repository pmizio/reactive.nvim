return {
  "tpope/vim-fugitive",
  dependencies = { "akinsho/git-conflict.nvim" },
  cmd = "G",
  config = function()
    local fn = vim.fn
    local config_autocmd = require("pmizio.utils").config_autocmd

    config_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)[1]

        if content ~= "" and type(content:find "^Merge branch") ~= "nil" then
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

    local get_current_file_gh_url = function()
      local user_repo = fn.system("git config --get remote.origin.url")
        :match "https://github%.com/([%w%d-/]+)%.git"
      if user_repo then
        local branch = fn.system("git branch --show-current"):gsub("%s*$", "")
        local file = vim.fn.expand "%:p:~:."
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local gh_url = "https://github.com/"
          .. user_repo
          .. "/blob/"
          .. branch
          .. "/"
          .. file
          .. "#L"
          .. line

        return gh_url
      end

      return nil
    end

    local open_in_gh = function()
      fn.system("open " .. get_current_file_gh_url())
    end

    vim.keymap.set("n", "<leader>go", open_in_gh)

    require("git-conflict").setup {
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    }
  end,
}
