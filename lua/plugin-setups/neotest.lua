require("neotest").setup({
	adapters = {
		require('neotest-jest')({
			-- Configure Jest options here
			jestCommand = "npm test --",
		}),
	},
})
