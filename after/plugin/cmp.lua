local cmp = require "cmp"
local lsp = require "lsp-zero"
local luasnip = require "luasnip"

local function nop() end

local select_opts = { behavior = cmp.SelectBehavior.Insert }

local cmp_mappings = lsp.defaults.cmp_mappings {
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
  ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
  ["<C-y>"] = cmp.mapping(function(fallback)
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif cmp.visible() then
      cmp.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
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
    format = require("lspkind").cmp_format {
      max_width = 50,
      mode = "symbol_text",
      symbol_map = { Copilot = "" },
    },
  },
  experimental = {
    ghost_text = true,
  },
}

table.insert(cmp_config.sources, 1, { name = "copilot" })

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
