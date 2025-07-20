return {
	'mfussenegger/nvim-dap',
	dependencies = {
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				require("dap-vscode-js").setup({
					node_path = "node", -- Or the path to your Node.js executable
					debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
					adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
				})

				require("dap").adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "ts-node",
						args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js", "${port}"},
					}
				}

				--[[
				require("dap").adapters["pwa-node"] = {
					type = "server",
					host = "js-debug-adapter",
					port = "${port}",
					executable = {
						command = "js-debug-adapter",
						args = { "${port}" },
					}
				}
				]]

				for _, language in ipairs({ "typescript", "javascript" }) do
					require("dap").configurations[language] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file (current)",
							program = "${file}",
							cwd = "${workspaceFolder}",
							resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
						},
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file (src/index.ts)",
							program = "src/index.ts",
							cwd = "${workspaceFolder}",
							resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
							resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
						},
					}
				end
			end,
		},
		{
			'rcarriga/nvim-dap-ui',
			dependencies = {
				'nvim-neotest/nvim-nio'
			}
		},
		{
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-treesitter/nvim-treesitter",
				"nvim-neotest/neotest-jest",
			},
			config = function()

				require("neotest").setup({
					adapters = {
						require("neotest-jest")({
							jestCommand = "npm test --",
							jestConfig = "jest.config.ts",
							env = { CI = true },
							cwd = function()
								return vim.fn.getcwd()
							end,
						}),
					},
				})

				--[[
				local dap = require('dap')
				local original_run = dap.run

				dap.run = function(config, ...)
					print(vim.inspect(config))
					return original_run(config, ...)
				end
				]]

				vim.keymap.set('n', '<leader>tt', ':lua require("neotest").run.run()<CR>', {}) -- run the nearest test
				vim.keymap.set('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {}) -- run the current file
				vim.keymap.set('n', '<leader>td', ':lua require("neotest").run.run({strategy = "dap"})<CR>', {}) -- debug the nearest test
				vim.keymap.set('n', '<leader>ts', ':lua require("neotest").run.stop()<CR>', {}) -- stop the nearest test
				vim.keymap.set('n', '<leader>ta', ':lua require("neotest").run.attach()<CR>', {}) -- attach to the nearest test

				vim.keymap.set('n', '<leader>to', ':lua require("neotest").output.open()<CR>', {}) -- open the output window ??

			end,
		},
		{
			'mfussenegger/nvim-dap-python',
			config = function()
				require('dap-python').setup('~/.local/share/virtualenvs/python-3.10-debugpy/bin/python')
				--[[
				table.insert(require('dap').configurations.python, {
					type = 'python',
					request = 'launch',
					name = 'Launch file',
					program = '${file}',
					-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
				})
				]]
			end,
		},
		'theHamsta/nvim-dap-virtual-text',
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set('n', '<F5>',				dap.continue, { desc = 'debug: start/continue' })
		vim.keymap.set('n', '<F10>',			dap.step_over, { desc = 'debug: step over' })
		vim.keymap.set('n', '<F11>',			dap.step_into, { desc = 'debug: step into' })
		vim.keymap.set('n', '<F12>',			dap.step_out, { desc = 'debug: step out' })
		vim.keymap.set('n', '<leader>b',	dap.toggle_breakpoint, { desc = 'debug: toggle breakpoint' })
		vim.keymap.set('n', '<leader>B',	function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'debug: set breakpoint' })
		vim.keymap.set('n', '<leader>lp',	function() dap.set_breakpoint(nil, nil, vim.fn.input'Log point message: ') end)
		vim.keymap.set('n', '<leader>dr',	dap.repl.open)

		-- Toggle to see last session result.  Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'debug: see last session result.' })

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		dapui.setup()
	end,
}
