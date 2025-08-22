return {
  "mfussenegger/nvim-jdtls",
  -- ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim/nvim-lspconfig",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "theHamsta/nvim-dap-virtual-text"
  },
  config = function()
    local jdtls = require("jdtls")

    local function attach_jdtls()
      local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/jdtls"
      local JAVA_DAP_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/"
      local JAVA_TEST_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/java-test/extension/server/"

      local HOME = os.getenv("HOME")
      local LOMBOK_PATH = JDTLS_LOCATION .. '/lombok.jar'
      local WORKSPACE_PATH = HOME .. "/workspace/temp/"

      -- Only for Linux and Mac
      local SYSTEM = "linux"
      if vim.fn.has "mac" == 1 then
        SYSTEM = "mac"
      end

      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local split_folder_name = vim.split(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h"), "/", {trimempty = true})

      -- vim.split(vim.fn.fnamemode(vim.fn.getcwd(), ":p:h"), "/",{trimempty=true} )
      if #split_folder_name < 3 then
        print("Debug propose: Java root not found")
        return
      end
      local project_id = split_folder_name[#split_folder_name-2] .. "/" .. split_folder_name[#split_folder_name-1]

      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

      local root_dir = require("jdtls.setup").find_root(root_markers)

      -- local WORKSPACE_PATH = root_dir .. "/.workspace/"
      local workspace_dir = WORKSPACE_PATH .. "/" .. project_id .. "/" .. project_name

      -- create the folder if .project does not exists
      if not vim.fn.isdirectory(workspace_dir) then
        vim.fn.mkdir(workspace_dir, "p")
      end

      if root_dir == "" then
        print("Debug propose: Java root not found")
        return
      end


      jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
      local extendedClientCapabilities = jdtls.extendedClientCapabilities;


      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dsgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. LOMBOK_PATH,
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          JDTLS_LOCATION .. "/config_" .. SYSTEM,
          "-data",
          workspace_dir,
        },

        root_dir = root_dir,

        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = HOME .. "/.sdkman/candidates/java/11.0.27-tem",
                },
                {
                  name = "JavaSE-17",
                  path = HOME .. "/.sdkman/candidates/java/17.0.16-librca",
                },
                {
                  name = "JavaSE-19",
                  path = HOME .. "/.sdkman/candidates/java/19-tem",
                },
                {
                  name = "JavaSE-20",
                  path = HOME .. "/.sdkman/candidates/java/20-tem",
                },
                {
                  name = "JavaSE-21",
                  path = HOME .. "/.sdkman/candidates/java/21-tem",
                }
              }
            },
            maven = {
              downloadSources = true,
            },
            implementationscodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enable = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            format = {
              enabled = true,
              settings = {
                url = "/home/ricardo/.local/share/eclipse/eclipse-java-google-style.xml",
                profile = "GoogleStyle",
              },
            },
          },
        },
        signatureHelp = { enable = true },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },

        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },

        flags = {
          allow_incremental_sync = true,
        },

      }

      -- local JAVA_DAP_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/"
      local bundles = {
        vim.fn.glob(JAVA_DAP_LOCATION .. "com.microsoft.java.debug.plugin-*.jar", 1)
      } 

      vim.list_extend(bundles, vim.split(vim.fn.glob(JAVA_TEST_LOCATION .. "*.jar", 1), "\n"))

      config["init_options"] = {
        bundles = bundles;
      }

      config['on_attach'] = function(_, bufrn)
        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }


        opts.buffer = bufrn
        opts.desc = "Show LSP declaration"
        keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        opts.desc = "Show documentations."
        keymap.set("n", "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        opts.desc = "Show implementations of the type."
        keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        opts.desc = "Show signature help."
        keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        opts.desc = "Show type definition."
        keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        opts.desc = "Rename."
        keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        opts.desc = "Show code actions."
        keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        opts.desc = "Format code"
        keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
        opts.desc = "Show references."
        keymap.set("n","<leader>lq", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
      end

      -- Existing server will be reused if the root_dir matches.
      jdtls.start_or_attach(config)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
      function get_spring_boot_runner(profile, debug)
        local debug_param = ""

        if (debug) then
          debug_param = " --debug-jvm "
        end

        local profile_param = ""
        if (profile) then
          profile_param = " --args=\"--spring.profiles.active=" .. profile .. "\" "
        end

        return "./gradlew bootRun " .. debug_param .. profile_param
      end

      function run_spring_boot(debug)
        -- vim.cmd('term ' .. get_spring_boot_runner('local', debug))
        vim.cmd("TermExec cmd='" .. get_spring_boot_runner('local', debug) .. "' ")
        -- vim.api.nvim_set_keymap("n", "<cmd>TermExec cmd='" .. get_spring_boot_runner() .. ";exit' <CR>", {noremap = true, silent = true})
      end

      function attach_to_debug()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup()
        dapui.open()

        dap.configurations.java = {
          {
            type = 'java',
            request = 'attach',
            name = "Attach to the process",
            hostName = 'localhost',
            port = '5005',
          }
        }
        dap.continue()
      end

      local keymap = vim.keymap

      keymap.set('n', '<Leader>da', ':lua attach_to_debug()<CR>')
      keymap.set('n', '<Leader>ds', ':lua run_spring_boot(true)<CR>')
      keymap.set('n', '<Leader>du', ':lua require("dapui").toggle()<CR>')
      keymap.set('n', '<Leader>joi', ':lua require("jdtls").organize_imports()<CR>')
      keymap.set('n', '<Leader>jc', ':lua require("jdtls").compile("incremental")<CR>')
      keymap.set('n', '<Leader>jsr', function() run_spring_boot() end)

      keymap.set('n', '<F9>', function() run_spring_boot(false) end)
      keymap.set('n', '<F10>', function() run_spring_boot(true) end)

      keymap.set('n', '<F5>', ':lua require"dap".continue()<CR>')
      keymap.set('n', '<F6>', ':lua require"dap".step_over()<CR>')
      keymap.set('n', '<F7>', ':lua require"dap".step_into()<CR>')
      keymap.set('n', '<F8>', ':lua require"dap".step_out()<CR>')

      keymap.set('n', '<Leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
      keymap.set('n', '<Leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
      keymap.set('n', '<Leader>dl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
      keymap.set('n', '<Leader>dr', ':lua require"dap".repl.open()<CR>')

      keymap.set('n', '<Leader>jtm', ':lua require("jdtls").test_nearest_method()<CR>')
      keymap.set('n', '<Leader>jtc', ':lua require("jdtls").test_class()<CR>')

      -- Git
      keymap.set('n', '<Leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>')

      function show_dap_centered_scopes()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end

      function show_dap_repl()
        local repl = require('dap').repl
        repl.open()
      end

      keymap.set('n', 'gs', ':lua show_dap_centered_scopes()<CR>')
      keymap.set('n', 'gR', ':lua show_dap_repl()<CR>')
    end

    attach_jdtls()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = java_filetypes,
      callback = attach_jdtls,
    })
  end
}
