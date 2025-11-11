
local diff_with_branch_prompt = function()
  local actions = require("telescope.actions")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local sorters = require("telescope.sorters")

  local branches = vim.fn.systemlist({ "git", "branch", "--format=%(refname:short)" })
  if vim.v.shell_error ~= 0 then
    vim.notify("Error getting git branches", vim.log.levels.ERROR)
    return
  end

  pickers.new({}, {
    prompt_title = "Select Branch to Diff Against",
    finder = finders.new_table({
      results = branches,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = require("telescope.actions.state").get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection[1] then
          vim.cmd("Gitsigns diffthis " .. selection[1])
        end
      end)
      return true
    end,
  }):find()
end


return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
        virt_text_pos = "eol",
      },
      current_line_blame_formatter = '\t\t<author> • <author_time:%Y-%m-%d> • <summary>',
    })

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    opts.desc = "Go to next hunk."
    keymap.set("n", "<leader>gn", "<cmd>lua require('gitsigns').next_hunk()<CR>", opts)
    opts.desc = "Go to previous hunk."
    keymap.set("n", "<leader>gp", "<cmd>lua require('gitsigns').prev_hunk()<CR>", opts)
    opts.desc = "Reset hunk."
    keymap.set("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", opts)
    opts.desc = "Preview hunk."
    keymap.set("n", "<leader>gP", "<cmd>lua require('gitsigns').preview_hunk()<CR>", opts)

    opts.desc = "Compare with another branch."
    keymap.set("n", "<leader>gc", diff_with_branch_prompt, opts)
  end
}
