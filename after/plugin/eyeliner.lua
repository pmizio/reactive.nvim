require("eyeliner").setup {
  highlight_on_key = true,
}

vim.cmd [[
  highlight EyelinerPrimary guifg='#ff0000' gui=underline ctermfg=196 cterm=underline
  highlight EyelinerSecondary guifg='#5fffff' gui=underline ctermfg=21 cterm=underline
]]
