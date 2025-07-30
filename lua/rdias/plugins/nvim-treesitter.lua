return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  config = function ()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true,
      },
      ident = {
        enable = true
      },
      autotag = {
        enable = true
      },
      auto_install = true,
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "lua",
        "graphql",
        "bash",
        "dockerfile",
        "vim",
        "gitignore",
        "query",
        "java",
        "rust",
        "python",
        "cpp",
        "c",
        "help",
        "vim",
        "cmake",
        "vimdoc",
        "hcl",
        "terraform",
        "http",
        "json"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
    })
  end
}
