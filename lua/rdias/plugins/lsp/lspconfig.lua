return {
  "neovim/nvim-lspconfig",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {"antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function ()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    local on_attach = function (_client, bufnr)
      opts.buffer = bufnr
      opts.desc = "Show LSP declaration"
      keymap.set("n", "lsp<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      opts.desc = "Show declaration location."
      keymap.set("n","<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      opts.desc = "Show definitions."
      keymap.set("n","<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      opts.desc = "Show documentations."
      keymap.set("n","<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      opts.desc = "Show implementations of the type."
      keymap.set("n","<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      opts.desc = "Show signature help."
      keymap.set("n","<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      opts.desc = "Show type definition."
      keymap.set("n","<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      opts.desc = "Rename."
      keymap.set("n","<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      opts.desc = "Show code actions."
      keymap.set("n","<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end

    -- Enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html" },
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          ss = true,
          javascript = true,
        },
      },
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typecriptreact", "javascriptreact", "css", "sass", "less" }
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("",true),
            checkThirdParty = false
          },
          telemetry = {
            enable = true
          }
        },
      },
    })

    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql" }
    })

    lspconfig["jdtls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })


  end
}
