return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>hh", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<cr>")
    keymap.set("n", "<leader>hm", "<CMD>lua require('harpoon.mark').add_file()<cr>")
    keymap.set("n", "<leader>hn", "<CMD>lua require('harpoon.ui').nav_next()<cr>")
    keymap.set("n", "<leader>hp", "<CMD>lua require('harpoon.ui').nav_pref()<cr>")
    keymap.set("n", "<leader>h1", "<CMD>lua require('harpoon.ui').nav_file(1)<cr>")
    keymap.set("n", "<leader>h2", "<CMD>lua require('harpoon.ui').nav_file(2)<cr>")
    keymap.set("n", "<leader>h3", "<CMD>lua require('harpoon.ui').nav_file(3)<cr>")
    keymap.set("n", "<leader>h4", "<CMD>lua require('harpoon.ui').nav_file(4)<cr>")
  end,
}
