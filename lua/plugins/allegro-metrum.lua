return {
  dir = "~/Documents/Allegro/devday/vscode-allegro-metrum",
  ft = { "css", "postcss" },
  config = function()
    local lsp = require "pmizio.lsp"
    local ok, metrum = pcall(require, "allegro-metrum")

    if ok then
      metrum.setup {
        on_attach = lsp.on_attach,
      }
    end
  end,
}
