return {
   "nvim-treesitter/nvim-treesitter-textobjects",
   event = { "BufReadPost", "BufNewFile" },
   dependencies = { "nvim-treesitter/nvim-treesitter" },
   config = function ()
     require("nvim-treesitter.configs").setup({
       textobjects = {
         select = {
           enable = true,
           lookahead = true,
           keymaps = {
             -- Check textobjects.scm
             ["a="] = { query = "@assignment.outer", desc = "Select outer part of assignment" },
           },
         },
         move = {
           enable = true,
           set_jumps = true,
           goto_next_start = {
               ["]f"] = { query = "@call.outer", desc = "Next function call start" },
           }
         }
       }
     })
   end
}
