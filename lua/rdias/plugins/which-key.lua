return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>d"] = { name = "+debug" }
    },
  },
  event = "VeryLazy",
  init = function ()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end
}
