local lspkind = require'lspkind'
local cmp = require'cmp'
local luasnip = require'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup{
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
						cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
				else
						fallback()
				end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
						cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
				else
						fallback()
				end
		end, { 'i', 's' }),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
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
			{ name = 'buffer', keyword_length = 5, max_item_count = 10 },
	}),
	formatting = {
		format = lspkind.cmp_format{
			with_text = true,
			menu = {
				luasnip = "[snip]",
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[lua]",
				path = "[path]",
			}
		}
	},
}

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

