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
    s({trig = '([%a%)%]%}])subs', regTrig = true, wordTrig = false, snippetType = 'autosnippet'}, {
	unpack(fmta(
	    "<>_{<>}",
	    {
		f( function(_, snip) return snip.captures[1] end ),
		i(1)
	    }
	))
    }),
    s({trig = 'ee', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[<>e^{<>}]],
	    {
		f(function(_, snip) return snip.captures[1] end),
		d(1, get_visual)
	    }
	))
    }),
    s({trig = 'int', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[\int_{<>}^{<>} <> \,<>]],
	    {
		i(1),
		i(2),
		i(3),
		i(4)
	    }
	))
    }),
    s({trig = 'sum', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[\sum_{<>}^{<>} <>]],
	    {
		i(1),
		i(2),
		i(3),
	    }
	))
    }),
    s({trig = 'vec', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[\langle <> \rangle]],
	    {
		i(1)
	    }
	))
    }),
    s({trig = 'pdv',snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[\pdv{<>}{<>}]],
	    {
		i(1),
		i(2)
	    }
	))
    }),
    s({trig = 'odv ', snippetType = 'autosnippet', condition = in_mathzone}, {
	unpack(fmta(
	    [[\odv{}{<>}[<>] ]],
	    {
		i(1),
		i(2)
	    }
	))
    }),
    s({trig = 'odv', condition = in_mathzone}, {
	unpack(fmta(
	    [[\odv{<>}{<>}]],
	    {
		i(1),
		i(2)
	    }
	))
    }),
    s({trig = 'df', snippetType = 'autosnippet', condition = in_mathzone},
	{t('\\diff')}
    )
}
