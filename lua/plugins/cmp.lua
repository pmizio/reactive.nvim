return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    local function nop() end

    local select_opts = { behavior = cmp.SelectBehavior.Insert }

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup {
      ---@diagnostic disable-next-line: missing-fields
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      preselect = cmp.PreselectMode.None,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
      }, {
        { name = "path" },
        { name = "buffer" },
      }),
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = require("lspkind").cmp_format {
          max_width = 50,
          mode = "symbol_text",
          symbol_map = { Copilot = "" },
        },
      },
      mapping = cmp.mapping.preset.insert {
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
      },
    }

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
