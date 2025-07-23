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
    s({trig=";r", snippetType="autosnippet"}, {
	t("\\rho"),
    }),
    s({trig=";s", snippetType="autosnippet"}, {
	t("\\sigma"),
    }),
    s({trig=";d", snippetType="autosnippet"}, {
	t("\\delta"),
    }),
    s({trig=";D", snippetType="autosnippet"}, {
	t("\\Delta"),
    }),
    s({trig=";e", snippetType="autosnippet"}, {
	t("\\epsilon"),
    }),
    s({trig=";z", snippetType="autosnippet"}, {
	t("\\zeta"),
    }),
    s({trig=";h", snippetType="autosnippet"}, {
	t("\\eta"),
    }),
    s({trig=";th", snippetType="autosnippet"}, {
	t("\\theta"),
    }),
    s({trig=";i", snippetType="autosnippet"}, {
	t("\\iota"),
    }),
    s({trig=";k", snippetType="autosnippet"}, {
	t("\\kappa"),
    }),
    s({trig=";l", snippetType="autosnippet"}, {
	t("\\lambda"),
    }),
    s({trig=";m", snippetType="autosnippet"}, {
	t("\\mu"),
    }),
    s({trig=";n", snippetType="autosnippet"}, {
	t("\\nu"),
    }),
    s({trig=";x", snippetType="autosnippet"}, {
	t("\\xi"),
    }),
    s({trig=";o ", snippetType="autosnippet"}, {
	t("\\o"),
    }),
    s({trig=";pi", snippetType="autosnippet"}, {
	t("\\pi"),
    }),
    s({trig=";ta", snippetType="autosnippet"}, {
	t("\\pi"),
    }),
    s({trig=";u", snippetType="autosnippet"}, {
	t("\\upsilon"),
    }),
    s({trig=";phi", snippetType="autosnippet"}, {
	t("\\upsilon"),
    }),
    s({trig=";c", snippetType="autosnippet"}, {
	t("\\chi"),
    }),
    s({trig=";psi", snippetType="autosnippet"}, {
	t("\\psi"),
    }),
    s({trig=";om", snippetType="autosnippet"}, {
	t("\\omega"),
    }),
    s({trig="tii", dscr="expands text to textit"}, {
	unpack(fmta("\\textit{<>}", {d(1, get_visual)}))
    }),
    s({trig = '([^%a])h1', regTrig = true, wordTrig = false, dscr='top-level section', snippetType = 'autosnippet', condition = line_begin and not in_mathzone}, {
	unpack(fmta(
	    [[\section{<>}]],
	    { i(1) }
	))
    }),
    s({trig = '([^%a])h2', regTrig = true, wordTrig = false, dscr='top-level section', condition = line_begin and not in_mathzone}, {
	unpack(fmta(
	    [[\subsection{<>}]],
	    { i(1) }
	))
    }),
    s({trig = '([^%a])h3', regTrig = true, wordTrig = false, dscr='top-level section', condition = line_begin and not in_mathzone}, {
	unpack(fmta(
	    [[\subsubsection{<>}]],
	    { i(1) }
	))
    }),
    s({trig = '([^%a])h3', regTrig = true, wordTrig = false, dscr='top-level section', condition = line_begin and not in_mathzone}, {
	unpack(fmta(
	    [[\subsubsection{<>}]],
	    { i(1) }
	))
    })
}
