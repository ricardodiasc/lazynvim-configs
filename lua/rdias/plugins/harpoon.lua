return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>hh", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<cr>")
    keymap.set("n", "<leader>hm", "<CMD>lua require('harpoon.mark').add_file()")
    keymap.set("n", "<leader>hn", "<CMD>lua require('harpoon.ui').nav_next()")
    keymap.set("n", "<leader>hp", "<CMD>lua require('harpoon.ui').nav_pref()")
    keymap.set("n", "<leader>h1", "<CMD>lua require('harpoon.ui').nav_file()")
  end,
}
