local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local log = require('plenary.log'):new {
  plugin = "telescope-docker",
  use_console = true,
}

local M = {}

M.show_docker_images = function()
  -- Execute docker to show only the name of the images using lua and vim api
  local docker_images = vim.fn.systemlist("docker images --format '{{.Repository}}'")
  return docker_images
end


print("Loaded telescope_docker")

M.show_telescope_pickers = function(opts)
  local docker_images = M.show_docker_images()
  pickers.new(opts,{
    prompt_title = 'Docker Images',
    finder = finders.new_table {
      results = docker_images,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      log.info("Selection: ", selection)
      if selection then
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          print("You selected: " .. selection .. ";")
        end)
      end
      return true
    end,
  }):find()
end

-- Add command on neovim to show the picker with the docker images
vim.cmd("command! DockerImages lua require('telescope_docker').show_telescope_pickers({})")

return M
