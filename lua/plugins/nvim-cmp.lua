local lspkind = require('lspkind')

local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	}
}

M.config = function()
	local cmp = require("cmp")

	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered()
		},
		mapping = cmp.mapping.preset.insert({
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-e>'] = cmp.mapping.abort(),
			['<C-Space>'] = cmp.mapping.complete(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'vsnip' }, -- For vsnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'buffer', keyword_length = 5 },
		}),
		formatting = {
			format = lspkind.cmp_format{
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[lua]",
					path = "[path]",
					luasnip = "[snip]"
				}
			}
		},
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
		})
	})

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
end

return M
