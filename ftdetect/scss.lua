vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "*.scss", command = "setf scss" }
)
