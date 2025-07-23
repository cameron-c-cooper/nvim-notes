local ls = require("luasnip")
local s= ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
	return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
	return sn(nil, i(1))
    end
end

return {
    s({trig="([^%a])fr", dscr="'\frac{}{}'", regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone},
    {
	unpack(fmta(
	    [[<>\frac{<>}{<>}]],
	    {
		f( function(_, snip) return snip.captures[1] end ),
		i(1),
		i(2)
	    }
	))
    }),
    s({trig = '([^%a])ee', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[<>e^{<>}]],
	    {
		f(function(_, snip) return snip.captures[1] end),
		d(1, get_visual)
	    }
	))
    }),
}
