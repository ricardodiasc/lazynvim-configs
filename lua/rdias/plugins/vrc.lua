return {
  "diepm/vim-rest-console",
  config = function ()
    -- local vrc = require("vim-rest-console")
    -- Disable default keybinding
    -- vim.g.vrc_set_default_mappping = 0
    vim.g.vrc_resonse_default_content_type = 'application/json'
    vim.g.vrc_output_buffer_name = '_OUTPUT.json'
    vim.g.vrc_auto_format_response_enabled = 1

    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq',
    }
  end
}
