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
    keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
    keymap.set('n', '<leader>xw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
    keymap.set('n', '<leader>xd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
    keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')

  end,
}
