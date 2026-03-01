return {
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  -- Optional: Configure UI and other settings
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = "~/.config/nvim/db_ui_queries" -- Customize save location
  end,
}
