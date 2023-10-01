require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"python",
		"lua",
		"json",
		"vim",
		"vimdoc",
		"dockerfile",
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
