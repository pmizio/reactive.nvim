local cmp = require "cmp"
local luasnip = require "luasnip"

local function nop() end

local function map_next_prev(cmp_function, luasnip_offset)
  return function(fallback)
    if cmp.visible() then
      cmp_function { behavior = cmp.SelectBehavior.Insert }(fallback)
    elseif luasnip.jumpable(luasnip_offset) then
      luasnip.jump(luasnip_offset)
    else
      fallback()
    end
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert {
    -- remapped by regular nvim to <C-j> and <C-k>
    ["<C-n>"] = cmp.mapping(map_next_prev(cmp.mapping.select_next_item, 1)),
    ["<C-p>"] = cmp.mapping(map_next_prev(cmp.mapping.select_prev_item, -1)),
    ["<Up>"] = nop,
    ["<Down>"] = nop,
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
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp", priority = 3 },
    { name = "nvim_lua", priority = 3 },
    { name = "luasnip", priority = 2 },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
      priority = 1,
    },
    { name = "path", priority = 1 },
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require("lspkind").cmp_format { with_text = true, maxwidth = 50 },
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
