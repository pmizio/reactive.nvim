local formtters = {
  {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    formatter = function()
      return {
        exe = "prettier",
        args = {
          "--stdin-filepath",
          vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          "--single-quote",
        },
        stdin = true,
      }
    end,
  },
  {
    "lua",
    formatter = function()
      return {
        exe = "stylua",
        args = { "-" },
        stdin = true,
      }
    end,
  },
}

local function mapFormatters()
  local filetypes = {}

  for _, formatter in ipairs(formtters) do
    for _, filetype in ipairs(formatter) do
      filetypes[filetype] = { formatter.formatter }
    end
  end

  return filetypes
end

require("formatter").setup {
  filetype = mapFormatters(),
}
