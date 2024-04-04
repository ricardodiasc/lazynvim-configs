return {
  "David-Kunz/gen.nvim",
  opts = {
    model = "deepseek-coder:6.7b",
    quit_map = "q",
    display_mode = 'float',
    show_prompt = false,
    show_model = false,
    no_auto_close = false,
    command = function (opts)
      local body = { model = opts.model, stream = true }
      return "curl --silent --no-buffer -X POST http://localhost:11434/api/chat -d $body"
    end,
    debug = false
  }
}
