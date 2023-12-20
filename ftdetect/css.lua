vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "*.css", command = "setf css" }
)
