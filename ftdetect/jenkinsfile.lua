vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "Jenkinsfile*", command = "setf jenkinsfile" }
)
