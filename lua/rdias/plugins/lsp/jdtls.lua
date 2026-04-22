return {
  "mfussenegger/nvim-jdtls",
  -- ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
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
      local WORKSPACE_PATH = HOME .. "/workspace/temp"

      -- Only for Linux and Mac
      local SYSTEM = "linux"
      if vim.fn.has "mac" == 1 then
        SYSTEM = "mac"
      end

      local root_markers = { "pom.xml", "build.gradle", "mvnw", "gradlew", ".git" }
      local root_dir = require("jdtls.setup").find_root(root_markers)

      if root_dir == "" then
        print("Java root not found")
        return
      end

      -- Detect whether the project uses Maven or Gradle (Maven takes priority)
      local function detect_build_tool()
        local has_mvnw = vim.fn.filereadable(root_dir .. "/mvnw") == 1
        local has_pom = vim.fn.filereadable(root_dir .. "/pom.xml") == 1
        local has_gradlew = vim.fn.filereadable(root_dir .. "/gradlew") == 1
        local has_build_gradle = vim.fn.filereadable(root_dir .. "/build.gradle") == 1
            or vim.fn.filereadable(root_dir .. "/build.gradle.kts") == 1

        if has_mvnw or has_pom then
          return "maven"
        elseif has_gradlew or has_build_gradle then
          return "gradle"
        end
        return nil
      end

      -- Return the executable command for the detected build tool
      local function get_build_cmd()
        local build_tool = detect_build_tool()
        if build_tool == "maven" then
          if vim.fn.filereadable(root_dir .. "/mvnw") == 1 then
            return "./mvnw"
          end
          return "mvn"
        elseif build_tool == "gradle" then
          if vim.fn.filereadable(root_dir .. "/gradlew") == 1 then
            return "./gradlew"
          end
          return "gradle"
        end
        return nil
      end

      local build_tool = detect_build_tool()
      local build_cmd = get_build_cmd()

      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = WORKSPACE_PATH .. "/" .. project_name

      -- create the folder if it does not exist
      if not vim.fn.isdirectory(workspace_dir) then
        vim.fn.mkdir(workspace_dir, "p")
      end

      local extendedClientCapabilities = jdtls.extendedClientCapabilities;
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local function get_sdkman_runtimes()
        local sdkman_java_dir = HOME .. "/.sdkman/candidates/java"
        local runtimes = {}
        
        -- Check if directory exists before globbing
        if vim.fn.isdirectory(sdkman_java_dir) == 0 then
          return nil
        end

        local java_dirs = vim.fn.glob(sdkman_java_dir .. "/*", false, true)

        -- Map to store the best candidate for each major version
        local major_map = {}

        for _, dir in ipairs(java_dirs) do
          if not dir:match("current$") then
            local version = vim.fn.fnamemodify(dir, ":t")
            local major = version:match("^(%d+)")
            if major then
              if not major_map[major] or version > major_map[major].version then
                major_map[major] = {
                  name = "JavaSE-" .. major,
                  path = dir,
                  version = version
                }
              end
            end
          end
        end

        -- Convert map back to list
        for _, runtime in pairs(major_map) do
          table.insert(runtimes, {
            name = runtime.name,
            path = runtime.path,
          })
        end

        return #runtimes > 0 and runtimes or nil
      end

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. LOMBOK_PATH,
          "-Xms1g",
          "-Xmx2g",
          "-Dsun.zip.disableMemoryMapping=true",
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
        capabilities = capabilities,

        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "automatic",
              runtimes = get_sdkman_runtimes()
            },
            maven = {
              downloadSources = true,
            },
            import = {
              maven = { enabled = true },
              gradle = { enabled = true },
            },
            autobuild = { enabled = true },
            implementationscodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enable = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            -- format = {
            --   enabled = true,
            --   settings = {
            --     url = "/home/ricardo/.local/share/eclipse/eclipse-java-google-style.xml",
            --     profile = "GoogleStyle",
            --   },
            -- },
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
      -- Only include actual plugin jars as bundles. 
      -- Helper jars like jacocoagent.jar or runner jars will crash JDT.LS if included here.
      local bundles = {}
      local dap_jar = vim.fn.glob(JAVA_DAP_LOCATION .. "com.microsoft.java.debug.plugin-*.jar", false)
      if dap_jar ~= "" then
        table.insert(bundles, dap_jar)
      end

      local test_bundle = vim.fn.glob(JAVA_TEST_LOCATION .. "com.microsoft.java.test.plugin-*.jar", false)
      if test_bundle ~= "" then
        table.insert(bundles, test_bundle)
      end

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
        if not build_cmd then
          print("No build tool detected (Maven or Gradle)")
          return nil
        end

        if build_tool == "gradle" then
          local debug_param = ""
          if debug then
            debug_param = " --debug-jvm"
          end
          local profile_param = ""
          if profile then
            profile_param = ' --args="--spring.profiles.active=' .. profile .. '"'
          end
          return build_cmd .. " bootRun" .. debug_param .. profile_param

        elseif build_tool == "maven" then
          local debug_param = ""
          if debug then
            debug_param = ' -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"'
          end
          local profile_param = ""
          if profile then
            profile_param = " -Dspring-boot.run.profiles=" .. profile
          end
          return build_cmd .. " spring-boot:run" .. debug_param .. profile_param
        end
      end

      function build_project()
        if not build_cmd then
          print("No build tool detected (Maven or Gradle)")
          return
        end
        if build_tool == "gradle" then
          vim.cmd("TermExec cmd='" .. build_cmd .. " build'")
        elseif build_tool == "maven" then
          vim.cmd("TermExec cmd='" .. build_cmd .. " package'")
        end
      end

      function clean_build_project()
        if not build_cmd then
          print("No build tool detected (Maven or Gradle)")
          return
        end
        if build_tool == "gradle" then
          vim.cmd("TermExec cmd='" .. build_cmd .. " clean build'")
        elseif build_tool == "maven" then
          vim.cmd("TermExec cmd='" .. build_cmd .. " clean package'")
        end
      end

      function run_spring_boot(debug)
        local cmd = get_spring_boot_runner('local', debug)
        if cmd then
          vim.cmd("TermExec cmd='" .. cmd .. "'")
        end
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

      keymap.set('n', '<Leader>jb', function() build_project() end)
      keymap.set('n', '<Leader>jB', function() clean_build_project() end)

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

    local java_filetypes = { "java" }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = java_filetypes,
      callback = attach_jdtls,
    })
  end
}
