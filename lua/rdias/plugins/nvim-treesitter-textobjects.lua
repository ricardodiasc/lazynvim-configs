return {
   "nvim-treesitter/nvim-treesitter",
   lazy = true,
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
               -- TODO finish the configuration for other text objects
               ["]f"] = { query = "@call.outer", desc = "Next function call start" },
           }
         }
       }
     })
   end
}
