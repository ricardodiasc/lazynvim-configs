return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function ()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

    nvimtree.setup({
      sort_by = "case_sensitive",
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
       filters = {
        dotfiles = false,
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>")
    -- keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
    -- keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
    -- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
    -- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
  end
}
