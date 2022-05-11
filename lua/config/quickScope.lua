local one_au = require("config.utils").create_onetime_autocmd

vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

local function QuickScopeColors()
  vim.cmd [[
    highlight QuickScopePrimary guifg='#ff0000' gui=underline ctermfg=196 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=21 cterm=underline
  ]]
end

QuickScopeColors()

one_au("ColorScheme", {
  pattern = "*",
  callback = QuickScopeColors,
})
