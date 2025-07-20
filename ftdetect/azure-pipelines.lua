vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "azure-pipelines*", command = "setf azure-pipelines" }
)
