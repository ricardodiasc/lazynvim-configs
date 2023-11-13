return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  config = function()
    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = " -> ",
          other_hints_prefix = " => ",
        },
      },
    })
  end,
}
