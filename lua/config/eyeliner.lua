local one_au = require("config.utils").create_onetime_autocmd

require("eyeliner").setup {
  highlight_on_key = true,
}

local function EyelinerColors()
  vim.cmd [[
    highlight EyelinerPrimary guifg='#ff0000' gui=underline ctermfg=196 cterm=underline
    highlight EyelinerSecondary guifg='#5fffff' gui=underline ctermfg=21 cterm=underline
  ]]
end

one_au("ColorScheme", {
  pattern = "*",
  callback = EyelinerColors,
})
