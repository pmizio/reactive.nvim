vim.diagnostic.config {
  underline = true,
  signs = {
    text = {
      ERROR = "✘",
      WARN = "▲",
      HINT = "⚑",
      INFO = "»",
    },
  },
  virtual_text = true,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code and not string.find(t.message, code, 1, true) then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}
