vim.g.python3_host_prog = '/usr/bin/python3'
--
-- vim.opt.runtimepath:prepend{'~/.nvim/runtime'}
require('opt')
--
require('plugin.dein')
require('plugin.nvim_lspconfig')
require('plugin.nvim_cmp')
require('plugin.cmp_nvim_lsp')
require('plugin.vim_vsnip')
require('plugin.tokyonight')

-- " terminal commands
vim.api.nvim_create_user_command('HTERMINAL', 'split|term', { nargs = 0})
vim.api.nvim_create_user_command('VTERMINAL', 'vsplit|term', { nargs = 0})
vim.api.nvim_create_user_command('TTERMINAL', 'tabnew %|lcd %:h|term', { nargs = 0})
vim.api.nvim_create_user_command('CTERMINAL', 'tabnew|lcd <args>|term', { nargs = 1, complete = 'dir' })

vim.keymap.set({'t', 'n'},  '<ESC>', '<C-\\><C-n>', { silent = true })

-- vim.cmd('filetype plugin indent on')
-- vim.cmd('syntax enable')
vim.cmd('colorscheme tokyonight-night')
vim.opt.termguicolors = true
vim.opt.mouse=''

