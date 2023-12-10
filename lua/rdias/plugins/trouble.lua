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
  end,
}
