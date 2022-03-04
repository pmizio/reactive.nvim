local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_range_formatting = false
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local function lsp_map(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {
      silent = true,
      buffer = bufnr,
    })
  end

  lsp_map("gD", vim.lsp.buf.declaration)
  lsp_map("gd", function()
    builtin.lsp_definitions(themes.get_ivy())
  end)
  lsp_map("gh", vim.lsp.buf.hover)
  lsp_map("gv", "<cmd>vs | lua vim.lsp.buf.definition()<CR>")
  lsp_map("gi", vim.lsp.buf.implementation)
  lsp_map("gs", vim.lsp.buf.signature_help)
  lsp_map("<space>D", vim.lsp.buf.type_definition)
  lsp_map("<space>rr", vim.lsp.buf.rename)
  lsp_map("<space>ca", vim.lsp.buf.code_action)
  lsp_map("gr", function()
    builtin.lsp_references(themes.get_ivy())
  end)
  lsp_map("[d", vim.lsp.diagnostic.goto_prev)
  lsp_map("]d", vim.lsp.diagnostic.goto_next)
end

local handlers = {
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
  }),
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  }),
}

local settings = {
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        completion = {
          -- You should use real snippets
          keywordSnippet = "Disable",
        },
        diagnostics = {
          enable = true,
          disable = { "trailing-space" },
          globals = {
            -- Neovim
            "vim",
            -- Busted
            "describe",
            "it",
            "before_each",
            "after_each",
            "teardown",
            "pending",
            "clear",
          },
        },
      },
    },
    -- Runtime configurations
    filetypes = { "lua" },
  },
}

require("nvim-lsp-installer").on_server_ready(function(server)
  server:setup(vim.tbl_extend("force", {
    autostart = true,
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
      if server.name == "eslint" then
        client.resolved_capabilities.document_formatting = true
        require("lsp-format").on_attach(client)
      else
        on_attach(client, bufnr)
      end
    end,
    handlers = handlers,
  }, settings[server.name] or {}))
  vim.cmd "do User LspAttachBuffers"
  require "config.lsp.diagnostics"
end)
