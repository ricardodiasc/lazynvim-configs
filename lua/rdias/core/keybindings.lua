local keymap = vim.keymap


keymap.set('n', 'te', ':tabedit<Return>')
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

