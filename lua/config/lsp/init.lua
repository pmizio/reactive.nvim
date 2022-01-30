local m = require "mapx"

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_range_formatting = false
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local buffer = { buffer = bufnr }

  m.nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "silent", buffer)
  m.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "silent", buffer)
  m.nnoremap("gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "silent")
  m.nnoremap("gv", "<cmd>vs | lua vim.lsp.buf.definition()<CR>", "silent", buffer)
  m.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "silent", buffer)
  m.nnoremap("gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "silent", buffer)
  m.nnoremap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "silent", buffer)
  m.nnoremap("<space>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", "silent")
  m.nnoremap("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "silent")
  m.nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "silent", buffer)
  m.nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "silent", buffer)
  m.nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "silent", buffer)
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
      client.resolved_capabilities.document_formatting = server.name == "eslint"
      on_attach(client, bufnr)
    end,
    handlers = handlers,
  }, settings[server.name] or {}))
  vim.cmd "do User LspAttachBuffers"
  require "config.lsp.diagnostics"
end)
