return {
  "David-Kunz/gen.nvim",
  opts = {
    model = "codellama",
    display_mode = 'float',
    show_prompt = false,
    show_model = false,
    no_auto_close = false,
    command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
    list_models = "<function>",
    debug = false
  }
}
