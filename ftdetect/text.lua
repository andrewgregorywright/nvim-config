vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{
		pattern = { "*.txt", "*.text" },
		command = "setf text"
	}
)
