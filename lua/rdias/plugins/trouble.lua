return {
  'folke/trouble.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
    require('trouble').setup {
      use_diagnostic_signs = true,
      action_keys = {
        close = 'q',
        refresh = 'r',
        jump = '<cr>',
      },
    }

    local keymap = vim.keymap
    keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')
    keymap.set('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
    keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle fulter.buf=0 <cr>')
    keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>')
    keymap.set('n', "<leader>xp", "<cmp>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

  end,
}
