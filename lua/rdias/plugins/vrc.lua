return {
  "diepm/vim-rest-console",
  config = function ()
    -- Disable default keymapping
    -- vim.g.vrc_set_default_mapping = 0

    vim.g.vrc_response_default_content_type = 'application/json'
    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq .',
    }
  end
}
