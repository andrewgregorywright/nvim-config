
----------------------------------------------------
-- setting options
----------------------------------------------------

require('settings')

----------------------------------------------------
-- lazy
----------------------------------------------------

require('setup-lazy')

----------------------------------------------------
-- syntax and color
----------------------------------------------------

require('syntax-and-color')

----------------------------------------------------
-- filetypes
----------------------------------------------------

vim.cmd('filetype plugin indent on')

local ftd_group = vim.api.nvim_create_augroup('filetypedetect', { clear = true })
vim.api.nvim_create_autocmd(
	{ 'BufEnter', 'BufNewFile' },
	{ pattern = 'wanderingarticles.conf', command = 'setf json', group = ftd_group }
)

----------------------------------------------------
-- autocommands
----------------------------------------------------

vim.api.nvim_create_autocmd(
	{ 'BufEnter' },
	{ pattern = '*', command = "if &buftype == 'terminal' | :startinsert | endif" }
)

----------------------------------------------------
-- mappings
----------------------------------------------------

vim.api.nvim_set_keymap('n', '<leader>s', ':execute "lvimgrep /\\v<" . expand("<cword>") . ">/j src/**/*.js"<cr>:lopen<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<Esc>:nohl<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><c-h>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w><c-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w><c-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w><c-l>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader><space>', 'za', { noremap = true })

-- vim.api.nvim_set_keymap('n', '<leader>f', ':call RegexKeyword()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('v', '<leader>vf', ':call LvimgrepVisualSelection()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>p', ':call CreatePropertiesSection(expand("<cword>"))<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>w', ':call CanonicalizeSectionNames()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>i', ':call LineUpImportsVertically(45)<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>a', ':call TmpAddEslintExceptionToAny()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>ff', ':call EchoSynInfo()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<cr>', { noremap = true })

----------------------------------------------------
-- help
----------------------------------------------------

vim.cmd('helptags ALL')

----------------------------------------------------
-- user commands
----------------------------------------------------

vim.api.nvim_create_user_command('H', 'tabnew | h | wincmd j | q | h <args>', { nargs = 1 })
-- command -range	ReqToImp	call ConvertRequireToImport(<line1>, <line2>)
-- vim.api.nvim_create_user_command('Al', 'call LineUpObjectLiteralVertically(<line1>, <line2>)', { range = true })
