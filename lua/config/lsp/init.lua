local lspconfig = require "lspconfig"
local lspinstaller = require "nvim-lsp-installer"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"
local m = require "config.utils.map"

local ensure_installed = {
  "tsserver",
  "eslint",
  "html",
  "jsonls",
  "sumneko_lua",
  "rust_analyzer",
  "clangd",
}

local function on_attach(client, bufnr)
  client.server_capabilities.documentRangeFormattingProvider = false

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local function lsp_map(lhs, rhs)
    m.nmap(lhs, rhs, { buffer = bufnr })
  end

  lsp_map("gD", vim.lsp.buf.declaration)
  lsp_map("gd", function()
    builtin.lsp_definitions(themes.get_ivy())
  end)
  lsp_map("gh", vim.lsp.buf.hover)
  lsp_map("gv", function()
    builtin.lsp_definitions(themes.get_ivy { jump_type = "vsplit" })
  end)
  lsp_map("gi", vim.lsp.buf.implementation)
  lsp_map("<leader>D", vim.lsp.buf.type_definition)
  lsp_map("<leader>rr", vim.lsp.buf.rename)
  lsp_map("<leader>ca", vim.lsp.buf.code_action)
  m.vmap("<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  lsp_map("gr", function()
    builtin.lsp_references(themes.get_ivy())
  end)
  lsp_map("[d", vim.diagnostic.goto_prev)
  lsp_map("]d", vim.diagnostic.goto_next)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  }),
}

local settings = {
  ["rust_analyzer"] = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

lspinstaller.setup {
  ensure_installed = ensure_installed,
  automatic_installation = true,
}

for _, server in pairs(lspinstaller.get_installed_servers()) do
  if server.name == "rust_analyzer" then
    require("rust-tools").setup {
      server = {
        capabilities = require("cmp_nvim_lsp").update_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        ),
        on_attach = on_attach,
        handlers = handlers,
        settings = settings[server.name],
      },
    }
  elseif server.name == "sumneko_lua" then
    local luadev = require("lua-dev").setup {
      lspconfig = {
        on_attach = on_attach,
      },
    }
    lspconfig[server.name].setup(luadev)
  elseif server.name == "tsserver" and vim.g.tsls ~= 1 then
  else
    lspconfig[server.name].setup(vim.tbl_extend("force", {
      capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      ),
      on_attach = function(client, bufnr)
        if server.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.renameProvider = false
          require("lsp-format").on_attach(client)
        else
          on_attach(client, bufnr)
        end
      end,
      handlers = handlers,
    }, {
      settings = settings[server.name] or {},
    }))
  end
end

require("fidget").setup {
  text = { spinner = "moon" },
}

require "config.lsp.diagnostics"

if vim.g.tsls ~= 1 then
  local ok, tsserver_nvim = pcall(require, "config.lsp.tsserver")
  if ok then
    tsserver_nvim.setup {
      on_attach = on_attach,
      settings = {
        composite_mode = "separate_diagnostic",
        debug = true,
        tsserver_logs = {
          verbosity = "verbose",
          file_basename = "/Users/pawel.mizio/.config/nvim/tsserver_",
        },
      },
    }
  end
end

require("lsp_signature").setup {
  floating_window = true,
  hint_enable = false,
}
