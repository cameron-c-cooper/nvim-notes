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
    s({trig="eq", dscr="LaTeX equation environment"},
    {
	unpack(fmt(
	    [[
	    \begin{equation}
	        <>
	    \end{equation}
	    ]],
	    { i(1) },
	    { delimiters = "<>" }
	))
    }),
    s({trig="beginend", snippetType="autosnippet"},
    {
	unpack(fmta(
	    [[
	    \begin{<>}
	        <>
	    \end{<>}
	    ]],
	    {
		i(1),
		i(2),
		rep(1)
	    },
	    { delimiters = "<>"}
	))
    }),
    s({trig = "([^%a])ile", wordTrig = false, regTrig = true, snippetType = 'autosnippet'}, {
	unpack(fmta(
	    "<>$<>$",
	    {
		f(function(_, snip) return snip.captures[1] end),
		i(1)
	    }
	))
    }),
    s({trig = "([^%a])nle", wordTrig = false, regTrig = true, snippetType = 'autosnippet'}, {
	unpack(fmt(
	    [[
		\begin{gather*}
		    <>
		\end{gather*}
	    ]],
	    {
		i(1)
	    },
	    { delimiters = "<>" }
	))
    }),
    s({trig = "^genmathnote", wordTrig = false, regTrig = true, snippetType = 'autosnippet'}, {
	unpack(fmta(
	    [[
		<>\documentclass{article}
		\usepackage{graphicx}
		\usepackage{amsmath}
		\usepackage{derivative}
		\usepackage{breqn}
		\newcommand{\diff}{\ensuremath{\operatorname{d}\!}}
		\title{<>}
		\author{Cameron C Cooper}
		\date{<>}
		\begin{document}
		\maketitle
		\section{<>}
		    <>
		\end{document}
	    ]],
	    {
		f( function(_, snip) return snip.captures[1] end ),
		i(1),
		i(2),
		i(3),
		i(4)
	    },
	    { delimiters = "<>" }
	))
    })
}
