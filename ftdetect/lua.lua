vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "*.lua", command = "setf lua" }
)
