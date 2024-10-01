require("neotest").setup({
	adapters = {
		require('neotest-jest')({
			-- Configure Jest options here
			jestCommand = "npm run dev:test -- --reporters=default",
			cwd = function()
				return vim.fn.getcwd()
			end,
		}),
	},
	--log_level = vim.log.levels.DEBUG,
	--log = {
		--enabled = true,
		--file = "/home/agwright/documents/delete/neotest_log.txt",
	--},
})
