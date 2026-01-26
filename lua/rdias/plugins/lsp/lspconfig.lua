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
    -- Enable virtual text diagnostics
    vim.diagnostic.config({ virtual_text = true })

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    opts.desc = "Show LSP declaration"
    keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
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
    keymap.set("n","<leader>lt", "<cmd>lua vi.lsp.buf.type_definition()<CR>", opts)
    opts.desc = "Rename."
    keymap.set("n","<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    opts.desc = "Show code actions."
    keymap.set("n","<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    opts.desc = "Show references."
    keymap.set("n","<leader>lq", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    opts.desc = "Go to next diagnostic."
    keymap.set("n","<leader>ln", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    opts.desc = "Format code."
    keymap.set("n","<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

    opts.desc = "Format selected code."
    keymap.set("v","<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

    opts.desc = "Show LSP declaration"
    keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

    -- Enable autocompletion
    -- local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- local lspconfig = require("lspconfig")
    --
    -- lspconfig.groovyls.setup({
    --   -- Optional: customize cmd if not using Mason (Mason usually handles this)
    --   -- cmd = { "java", "-jar", "/path/to/groovy-language-server-all.jar" },
    --   root_dir = lspconfig.util.root_pattern(".git", "build.gradle", "Jenkinsfile"),
    --   settings = {
    --     groovy = {
    --       classpath = {
    --         -- Update these paths to point to your shared library src/vars
    --         "/path/to/your/cloned/shared-library/src",
    --         "/path/to/your/cloned/shared-library/vars"
    --       }
    --     }
    --   }
    -- })

  end
}
