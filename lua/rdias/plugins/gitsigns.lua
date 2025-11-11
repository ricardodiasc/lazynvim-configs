
local diff_with_branch_prompt = function()
  -- Use vim.ui.input to open a dialog and get user input
  vim.ui.input({
    prompt = "Enter branch/revision to diff against (e.g., main, HEAD~1): ",
    default = "develop" -- Optional default value
  }, function(input)
    -- This callback function is executed after the user presses Enter

    -- 'input' is the string the user typed
    if input and input ~= '' then
      -- Execute the Gitsigns diffthis command with the user's input
      vim.cmd("Gitsigns diffthis " .. input)
    else
      -- Optional: Handle case where user cancels or enters empty string
      vim.notify("Diff cancelled or no revision entered", vim.log.levels.INFO)
    end
  end)
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
