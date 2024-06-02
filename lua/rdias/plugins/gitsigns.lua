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
    keymap.nnoremap({ "<leader>gn", "<cmd>lua require('gitsigns').next_hunk()<CR>" })
    keymap.nnoremap({ "<leader>gp", "<cmd>lua require('gitsigns').prev_hunk()<CR>" })
    keymap.nnoremap({ "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>" })

  end
}
