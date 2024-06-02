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
  end
}
