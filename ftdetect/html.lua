vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "*.html", command = "setf html" }
)
