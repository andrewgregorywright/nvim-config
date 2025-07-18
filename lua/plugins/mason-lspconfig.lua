return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	opts = {},
	config = function()
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set('n', '<leader>ln',	vim.diagnostic.open_float)
		vim.keymap.set('n', '[d',			vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d',			vim.diagnostic.goto_next)
		vim.keymap.set('n', '<leader>lo',	vim.diagnostic.setloclist)
	end
}
