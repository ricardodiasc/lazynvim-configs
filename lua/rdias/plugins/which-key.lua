return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function ()
    vim.o.timesout = true
    vim.o.timeoutlen = 500
  end
}
