local picker = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local log = require('plenary.log'):new {
  plugin = "telescope-docker",
  use_console = true,
}

local M = {}


M.docker_images = function(opts)
  picker.new(opts, {
    finder = finders.new_async_job {
      command_generator = function()
        return { "docker", "images", "--format", "json" }
      end,
      entry_maker = function(entry)
        local parsed = vim.json.decode(entry)
        return {
          value = parsed,
          display = parsed.Repository,
          ordinal = parsed.Repository .. ":" .. parsed.Tag,
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
        actions.close(prompt_bufnr)
        log.info("Selected entry: ", selection.value.Repository)
        local command = "edit term://docker run -it " .. selection.value.Repository .. ":" .. selection.value.Tag
        vim.cmd(command)
      end)
      return true
    end,

  }):find()
end

-- add command to show options on neovim using lua 
vim.cmd("command! ShowOptions lua require('telescope-docker').docker_images({})")


return M
