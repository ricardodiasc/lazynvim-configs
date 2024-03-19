return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  opts = {
  },
  keys = {
    {
      "<Leader>du",
      function ()
        require("dapui").toggle()
      end,
      desc = "Toggle DAP UI"
    },
    {
      "<Leader>b",
      function ()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<F5>",
      function ()
        require("dap").continue()
      end,
    },
    {
      "<F6>",
      function ()
        require("dap").step_over()
      end,
    },
    {
      "<F7>",
      function ()
        require("dap").step_into()
      end,
    },
    {
      "<F8>",
      function ()
        require("dap").step_out()
      end,
    }
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = 8123,
      executable = {
        command = "js-debug-adapter",
      },
    }

    for _, lang in pairs({ "javascript", "typescript" }) do
      dap.configurations[lang] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          runtimeExecutable = "node",
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }
    end


    dapui.setup({})

    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --   dapui.open()
    -- end
    --
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
