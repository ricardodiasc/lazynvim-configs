return {
  "numToStr/Comment.nvim",
  event = { "BufNewFile", "BufReadPre" }, -- load when buf open with a file
  config = true -- runs require('Comment').setup()
}
