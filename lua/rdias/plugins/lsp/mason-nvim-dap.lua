return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mason.nvim",
  },
  cmd = {
    "DapInstall",
    "DapUnistall",
  },
  opts = {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
      "nvim-dap",
      "nvim-dap-ui",
      "nvim-dap-virtual-text",
      "nvim-dap-python",
      "nvim-dap-go",
      "nvim-dap-rust",
      "nvim-dap-php",
      "nvim-dap-cpp",
      "nvim-dap-java",
      "nvim-dap-docker",
      "nvim-dap-chrome",
      "nvim-dap-flutter",
      "nvim-dap-ghcide",
      "nvim-dap-lldb",
      "nvim-dap-lua",
      "nvim-dap-node",
      "nvim-dap-ruby-debugger",
      "nvim-dap-rust",
      "nvim-dap-virtual-text",
    },
  },
}
