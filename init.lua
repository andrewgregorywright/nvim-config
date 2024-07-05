----------------------------------------------------
-- setting options
----------------------------------------------------

require('settings')

----------------------------------------------------
-- temporary stuff
----------------------------------------------------

--vim.api.nvim_set_keymap('n', '<leader>f', ':w | luafile %<CR>', { noremap = true })

----------------------------------------------------
-- bootstrap lazy
----------------------------------------------------

require('setup-lazy')

----------------------------------------------------
-- configure plugins
----------------------------------------------------

require('plugin-setups.nvim-treesitter')
require('plugin-setups.telescope')
require('plugin-setups.nvim-lspconfig')
require('plugin-setups.nvim-cmp')
require('plugin-setups.mason')
-- Might try this again at some point....
-- require('plugin-setups.neotest')

----------------------------------------------------
-- syntax and color
----------------------------------------------------

require('syntax-and-color')

----------------------------------------------------
-- filetypes
----------------------------------------------------

vim.cmd('filetype plugin indent on')

----------------------------------------------------
-- autocommands
----------------------------------------------------

vim.api.nvim_create_autocmd(
	{ 'BufEnter' },
	{ pattern = '*', command = "if &buftype == 'terminal' | startinsert | endif" }
)

----------------------------------------------------
-- mappings
----------------------------------------------------

vim.keymap.set('n', '<leader>s', ':execute "lvimgrep /\\v<" . expand("<cword>") . ">/j src/**/*.js"<cr>:lopen<cr>', { noremap = true, desc = "Search for the word under the cursor." })
vim.keymap.set('n', '<leader>h', '<Esc>:nohl<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', '<Esc>:Neotree<cr>', { noremap = true, silent = true })

vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { noremap = true })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { noremap = true })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { noremap = true })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { noremap = true })

vim.keymap.set('n', '<leader><space>', 'za', { noremap = true })

-- vim.keymap.set('n', '<leader>f', ':call RegexKeyword()<cr>', { noremap = true })
-- vim.keymap.set('v', '<leader>vf', ':call LvimgrepVisualSelection()<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>p', ':call CreatePropertiesSection(expand("<cword>"))<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>w', ':call CanonicalizeSectionNames()<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>i', ':call LineUpImportsVertically(45)<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>a', ':call TmpAddEslintExceptionToAny()<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>ff', ':call EchoSynInfo()<cr>', { noremap = true })
-- vim.keymap.set('n', '<leader>t', ':tabnew<cr>', { noremap = true })

----------------------------------------------------
-- help
----------------------------------------------------

vim.cmd('helptags ALL')

----------------------------------------------------
-- user commands
----------------------------------------------------

vim.api.nvim_create_user_command('H', 'tabnew | h | wincmd k | q | h <args>', { nargs = 1 })
-- command -range	ReqToImp	call ConvertRequireToImport(<line1>, <line2>)
-- vim.api.nvim_create_user_command('Al', 'call LineUpObjectLiteralVertically(<line1>, <line2>)', { range = true })
