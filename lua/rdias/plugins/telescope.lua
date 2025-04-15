return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim" , build = "make" },
    "folke/trouble.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local source = require("trouble.sources.telescope")
    local actions = require("telescope.actions")

    telescope.setup {
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer
            },
            n = {
              ["<c-d>"] = actions.delete_buffer
            }
          }
        }
      },
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<c-l>"] = source.open
          },
          n = {
            ["<c-l>"] = source.open
          }
        },
      },
    }

    telescope.load_extension("fzf")

    local keymap = vim.keymap
    keymap.set("n", ";f", "<cmd>Telescope find_files<cr>")
    keymap.set("n", ";g", "<cmd>Telescope live_grep<cr>")

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>")
    keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>")
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>")
    keymap.set("n", "<Leader>fb", "<cmd>Telescope git_branches<cr>")
    keymap.set("n", "<Leader>fs", "<cmd>Telescope git_status<cr>")
    keymap.set("n", "<Leader>fd", "<cmd>Telescope git_bcommits<cr>")
    keymap.set("n", "<Leader>fr", "<cmd>Telescope registers<cr>")
    keymap.set("n", "<Leader>fm", "<cmd>Telescope marks<cr>")
    keymap.set("n", "<Leader>fl", "<cmd>Telescope loclist<cr>")
    keymap.set("n", "<Leader>fq", "<cmd>Telescope quickfix<cr>")
    keymap.set("n", "<Leader>ft", "<cmd>Telescope treesitter<cr>")
    keymap.set("n", "<Leader>fo", "<cmd>Telescope oldfiles<cr>")
    keymap.set("n", "<Leader>fw", "<cmd>Telescope grep_string<cr>")
  end
}
