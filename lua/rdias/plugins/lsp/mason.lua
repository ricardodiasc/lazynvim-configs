return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
          package_installed = "",
          package_outdated = "",
          package_not_installed = "",
          package_pending = "",

        },
      }
    })
    mason_lspconfig.setup({
      ensure_installed = {
        "cssls",
        "tailwindcss",
        "emmet_ls",
        "html",
        "lua_ls",
        "graphql",
        "tsserver",
        "jdtls",
      },
      automatic_installation = true,
    })
  end,
}
