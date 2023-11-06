return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "java-test", "java-debug-adapter"
    })
  end,
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
        "marksman",
        "angularls",
        "jsonls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service"
      },
      automatic_installation = true,
    })
  end,
}
