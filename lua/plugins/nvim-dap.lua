return {
	'mfussenegger/nvim-dap',
	dependencies = {
		{
			'rcarriga/nvim-dap-ui',
			dependencies = {
				'nvim-neotest/nvim-nio'
			}
		},
		'mfussenegger/nvim-dap-python',
		'theHamsta/nvim-dap-virtual-text',
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set('n', '<F5>',				dap.continue, { desc = 'debug: start/continue' })
		vim.keymap.set('n', '<F9>',				dap.step_over, { desc = 'debug: step over' })
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
}
