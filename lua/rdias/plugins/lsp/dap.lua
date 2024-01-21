return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
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
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({})

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
