local config = {
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or d.user_data.lsp.code
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}

vim.diagnostic.config(config)

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

local t = vim.fn.sign_getdefined "DiagnosticSignWarn"
if vim.tbl_isempty(t) then
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

local last_popup_cursor = { nil, nil }

require("config.utils").create_onetime_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)

    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
      last_popup_cursor = current_cursor
      vim.diagnostic.open_float(0, { scope = "cursor" })
    end
  end,
})
