return {
  "akinsho/nvim-toggleterm.lua",

  config = function()
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>T", "<cmd>ToggleTerm direction=float<CR>", {noremap = true, silent = true}) 
    require("toggleterm").setup {
      size = 12,
      open_mapping = [[<c-t>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    }
  end,
}
