vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "*.sh", command = "setf sh" }
)
