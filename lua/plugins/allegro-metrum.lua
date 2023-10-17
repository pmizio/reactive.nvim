return {
  dir = "~/Documents/Allegro/devday/vscode-allegro-metrum",
  ft = { "css", "postcss" },
  config = function()
    local on_attach = require "pmizio.on_attach"
    local ok, metrum = pcall(require, "allegro-metrum")

    if ok then
      metrum.setup {
        on_attach = on_attach,
      }
    end
  end,
}
