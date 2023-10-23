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
      keymap.nnoremap("<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      opts.desc = "Show declaration location."
      keymap.nnoremap("<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      opts.desc = "Show definitions."
      keymap.nnoremap("<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      opts.desc = "Show documentations."
      keymap.nnoremap("<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      opts.desc = "Show implementations of the type."
      keymap.nnoremap("<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      opts.desc = "Show signature help."
      keymap.nnoremap("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      opts.desc = "Show type definition."
      keymap.nnoremap("<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      opts.desc = "Rename."
      keymap.nnoremap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      opts.desc = "Show code actions."
      keymap.nnoremap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      opts.desc = "Show references"
      keymap.nnoremap("<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      keymap.nnoremap("<leader>lE", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
      keymap.nnoremap("<leader>l[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
      keymap.nnoremap("<leader>l]", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
      keymap.nnoremap("<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
      keymap.nnoremap("<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
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
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [] = true,
            },
          }
        },
      },
    })

    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
