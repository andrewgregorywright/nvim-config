local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
	defaults = {
		file_ignore_patterns = {
			".git",
			"node_modules"
		}
	},
	pickers = {
		find_files = {
			hidden = true
		}
	}
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
