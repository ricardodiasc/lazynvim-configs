vim.g.nightflyTransparent = true

vim.g.mapleader = ' '

vim.g.markdown_fenced_languages = {"html", "javascript", "typescript", "css", "scss", "lua", "java"}

vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.wo.relativenumber = true

vim.opt.hlsearch = true
vim.showcmd = true
vim.opt.backup = false
vim.opt.cmdheight = 1

vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10

if vim.fn.executable('zsh') == 1  then
  vim.opt.shell = 'zsh'
end


vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*', '*/.git/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = 'set nopaste'
})

vim.opt.formatoptions:append { 'r' }


-- Clipboard
local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"
local is_linux = has "linux"

if is_mac then
  vim.opt.clipboard:append { "unnamedplus" }
end
if is_win then
  vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
end
if is_linux then
  vim.opt.clipboard:append { "unnamedplus" }
end

vim.keymap.set('n', 'te', ':tabedit<Return>')
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
vim.keymap.set('n', 'tc', ':tabclose<Return>')
-- vim.keymap.set('n', '<Tab>', ':tabnext<Return>')

vim.keymap.set('n', '<Leader>bd', ':bd<Return>')
vim.keymap.set('n', '<Leader>bn', ':bn<Return>')
vim.keymap.set('n', '<Leader>bp', ':bp<Return>')

-- require('rdias.core.keybindings')




-- vim.g.clipboard = {
--   name = "win32yank",
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf"
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --crlf",
--     ["*"] = "win32yank.exe -o --crlf"
--   },
--   cache_enabled = false
-- }
--





-- Complete

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
