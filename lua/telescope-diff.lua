local M = {}

M.compare_to_current = function(opts)
  local current_win = vim.api.nvim_get_current_win()
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  builtin.find_files({
      prompt_title = "Select File to Compare",
      attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local selected_file = selection.path
              -- Open vertical diff split with the selected file
              vim.cmd('vertical diffsplit ' .. vim.fn.fnameescape(selected_file))
          end)
          return true
      end
  })
end

M.stop_compare = function()
  vim.cmd("diffoff!")
  vim.cmd("bd")
end

vim.cmd("command! CompareFile lua require('telescope-diff').compare_to_current({})")
vim.cmd("command! StopCompare lua require('telescope-diff').stop_compare()")

return M
