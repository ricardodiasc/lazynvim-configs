local picker = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local log = require('plenary.log'):new {
  plugin = "telescope-test",
  use_console = true,
}

local M = {}


M.show_options = function(opts)
  picker.new(opts, {
    finder = finders.new_table {
      results = {
        {name = "Yes", value = {1,2,3,4}},
        {name = "No", value = {1,2,3,4}},
        {name = "Maybe", value = {1,2,3,4}},
        {name = "Perhaps", value = {1,2,3,4}},
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    },
    sorter = config.generic_sorter(opts),
    previewer = previewers.new_buffer_previewer {
      title = "Docker Image",
      define_preview = function(self, entry)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, false, vim.fn.split(vim.inspect(entry.value), "\n"))
        utils.highlighter(self.state.bufnr, "lua")
      end,
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        log.info("Selected entry: ", selection.value.name)
        actions.close(prompt_bufnr)
      end)
      return true
    end,

  }):find()
end

-- add command to show options on neovim using lua 
vim.cmd("command! ShowOptions lua require('telescope-test').show_options({})")


return M
