return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.2',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function () 
				local configs = require("nvim-treesitter.configs")

				configs.setup({
					ensure_installed = {
						"bash",
						"c",
						"python",
						"lua",
						"json",
						"vim",
						"vimdoc",
						"query",
						"elixir",
						"heex",
						"javascript",
						"typescript",
						"tsx",
						"html"
					},
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },  
				})

				local builtin = require('telescope.builtin')
				vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
				vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
				vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
				vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			end
		}
	}
}
