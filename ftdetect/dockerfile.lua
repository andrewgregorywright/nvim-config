vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "Dockerfile", command = "setf dockerfile" }
)
