local ls = require 'luasnip'

--[[
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
--]]

ls.add_snippets('typescript', {
	--[[
	s('func', {
			t('function '),
			i(1, 'functionName'),
			t('('),
			i(2, 'params'),
			t('): '),
			i(3, 'returnType'),
			t({' {', '\t'}),
			i(4, 'body'),
			t({'', '}'})
	}),
	--]]
	ls.parser.parse_snippet('stryc', 'try {\n\t$0\n} catch (err) {\n}'),
	ls.parser.parse_snippet('scl', 'console.log(\'$0\')'),
	ls.parser.parse_snippet('sce', 'console.error(\'$0\')'),
})

