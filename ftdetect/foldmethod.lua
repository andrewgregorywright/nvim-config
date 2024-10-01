vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, { pattern = "src/routes/*.ts", command = "setlocal foldmethod=marker" })
