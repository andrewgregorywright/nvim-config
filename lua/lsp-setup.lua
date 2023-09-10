local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}									-- installed via "npm i -g pyright"
lspconfig.docker_compose_language_service.setup{}			-- installed via "npm i -g @microsoft/compose-language-service"
lspconfig.dockerls.setup{}									-- installed via "npm i -g dockerfile-language-server-nodejs"
lspconfig.bashls.setup{}									-- installed via "npm i -g bash-language-server"
lspconfig.lua_ls.setup{										-- installed from https://github.com/LuaLS/lua-language-server/releases/tag/3.7.0 into ~/bin
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					'vim'
				}
			}
		}
	}
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>ln',	vim.diagnostic.open_float)
vim.keymap.set('n', '[d',			vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d',			vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>lo',	vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>lK', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>lwl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>lc', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>le', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>lf', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
