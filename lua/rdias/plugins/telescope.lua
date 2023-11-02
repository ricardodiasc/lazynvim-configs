return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim" , build = "make" }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    }

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>")
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>")
    keymap.set("n", "<Leader>fb", "<cmd>Telescope git_branches<cr>")
  end
}
