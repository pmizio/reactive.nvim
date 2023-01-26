local cmp = require "cmp"
local lsp = require "lsp-zero"

local function nop() end

local select_opts = { behavior = cmp.SelectBehavior.Insert }

local cmp_mappings = lsp.defaults.cmp_mappings {
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
  ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
  ["<Tab>"] = nil,
  ["<S-Tab>"] = nop,
  ["<Up>"] = nop,
  ["<Down>"] = nop,
  ["<CR>"] = nil,
}

local cmp_config = lsp.defaults.cmp_config {
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp_mappings,
  window = {
    completion = cmp.config.window.bordered(),
  },
  formatting = {
    format = require("lspkind").cmp_format { with_text = true, maxwidth = 50 },
  },
  experimental = {
    ghost_text = true,
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup(cmp_config)
