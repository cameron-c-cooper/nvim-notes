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

-- basic snippet
-- s(
--     context:table,
--     nodes:table,
--     opts:table|nil
-- )

-- sample snippet (specifically a text node)
-- require("luasnip").snippet (
    -- {
	-- trig="hi",
	-- dscr="an autotriggering snippet that expands 'hi' into 'Hello, world!'",
	-- regTrig=false,
	-- priority=100,
	-- snippetType="autosnippet"
    -- },
    -- {
	-- t("Hello, world!"),
    -- }
    -- Table 3, adv. snippet opts is left blank
-- )

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
	return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
	return sn(nil, i(1))
    end
end

return {
    s({trig="tt", dscr="'\texttt{}'"},
    {
	t("\\texttt{"),
	i(1),
	t("}")
    }),
    s({trig=";a", snippetType="autosnippet"}, {
	t("\\alpha"),
    }),
    s({trig=";b", snippetType="autosnippet"}, {
	t("\\beta"),
    }),
    s({trig=";g", snippetType="autosnippet"}, {
	t("\\gamma"),
    }),
    s({trig="tii", dscr="expands text to textit"}, {
	unpack(fmta("\\textit{<>}", {d(1, get_visual)}))
    }),
    s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType = 'autosnippet'}, {
	unpack(fmta(
	    "<>_{<>}",
	    {
		f( function(_, snip) return snip.captures[1] end ),
		i(1)
	    }
	))
    }),
    s({trig = 'h1', dscr='top-level section', condition = line_begin}, {
	unpack(fmta(
	    [[\section{<>}]],
	    { i(1) }
	))
    }),
    s({trig = 'h2', dscr='top-level section', condition = line_begin}, {
	unpack(fmta(
	    [[\subsection{<>}]],
	    { i(1) }
	))
    }),
    s({trig = 'h3', dscr='top-level section', condition = line_begin}, {
	unpack(fmta(
	    [[\subsubsection{<>}]],
	    { i(1) }
	))
    }),
    s({trig = 'h3', dscr='top-level section', condition = line_begin}, {
	unpack(fmta(
	    [[\subsubsection{<>}]],
	    { i(1) }
	))
    })
}
