local mason_lspconfig = require 'mason-lspconfig'

local servers = {
	html = { filetypes = { 'html', 'twig', 'hbs'} },
	pyright = {},
	docker_compose_language_service = {},
	dockerls = {},
	bashls = {},
	ts_ls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = {
					'vim'
				}
			}
		}
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = 'LSP: ' .. desc
					end

					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('<leader>lr', vim.lsp.buf.rename, 'rename')
				nmap('<leader>lc', vim.lsp.buf.code_action, 'code action')

				nmap('<leader>ld', vim.lsp.buf.definition, 'goto definition')
				nmap('<leader>le', require('telescope.builtin').lsp_references, 'goto references')
				nmap('<leader>li', require('telescope.builtin').lsp_implementations, 'goto implementation')
				nmap('<leader>lt', vim.lsp.buf.type_definition, 'Type definition')
				nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'document symbols')
				nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

				-- See `:help K` for why this keymap
				nmap('<leader>lK', vim.lsp.buf.hover, 'hover documentation')
				nmap('<leader>ls', vim.lsp.buf.signature_help, 'signature documentation')

				-- Lesser used LSP functionality
				nmap('<leader>lD', vim.lsp.buf.declaration, 'goto declaration')
				nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'workspace add Folder')
				nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'workspace remove Folder')
				nmap('<leader>lwl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, 'workspace list Folders')

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					vim.lsp.buf.format()
				end, { desc = 'Format current buffer with LSP' })
			end,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end
}
