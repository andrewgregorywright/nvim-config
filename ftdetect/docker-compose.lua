vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "docker-compose*.yml", command = "setf dockercompose" }
)
