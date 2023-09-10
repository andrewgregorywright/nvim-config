-- Detecting DNS zone files
vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" },
	{ pattern = "db.*", command = "setf zonefile" }
)
