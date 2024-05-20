----------------------------------------------------
-- settings
----------------------------------------------------

vim.o.number			= true
vim.o.autoindent	= true
vim.o.hlsearch		= true
vim.o.incsearch		= true
vim.o.wildmenu		= true
vim.o.hidden			= true
vim.o.foldcolumn	= 'auto'
vim.o.tabstop			= 2
vim.o.softtabstop	= 2
vim.o.shiftwidth	= 2
vim.o.splitbelow	= true
vim.o.splitright	= true
vim.o.shm			= 'Fc'
-- disabling backup files for conquer of completion
vim.o.nobackup		= true
vim.o.nowritebackup = true
-- recommended for conquer of completion
-- vim.o.updatetime	= 300
-- recommended for conquer of completion
-- vim.o.signcolumn	= 'yes'
-- vim.opt.suffixes:append({ '.js' })
-- vim.opt.suffixes:append({ '.ts' })
-- Set the height of the command history window
vim.o.cmdwinheight	= 15
-- This prevents vimgrep from searching in the node_modules subfolder
vim.opt.wildignore:append({ '**/node_modules/**', 'node_modules/**' })
-- Set the fold method
vim.o.foldmethod	= 'marker'
vim.g.mapleader		= " "

vim.g.python3_host_prog = '/home/agwright/.pyenv/shims/python'
vim.g.loaded_python_provider = 0

-- Switch to the previously active tab
vim.g.lasttab = 1
vim.api.nvim_set_keymap('n', '<leader>g', ':exe "tabn " . g:lasttab<cr>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd('TabLeave', { pattern = '*', command = 'let g:lasttab = tabpagenr()' })

vim.o.path = '.,,/usr/include,src/website/client/ui'
