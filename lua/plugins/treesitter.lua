return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPre",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "css",
        "html",
        "rust",
        "lua",
        "query",
        "vim",
        "markdown",
        "markdown_inline",
        "comment",
        "jsdoc",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ab"] = { query = "@braces.around", query_group = "surroundings" },
            ["ib"] = { query = "@braces.inner", query_group = "surroundings" },
            ["aq"] = { query = "@quotes.around", query_group = "surroundings" },
            ["iq"] = { query = "@quotes.inner", query_group = "surroundings" },
          },
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      autotag = {
        enable = true,
      },
    }
  end,
}
