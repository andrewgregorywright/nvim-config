local ls = require 'luasnip'

--[[
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
--]]

ls.add_snippets('lua', {
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
		ls.parser.parse_snippet('func', 'ifunction ${1:name}(${2:args}) {\n\t${3}\n}')
})

