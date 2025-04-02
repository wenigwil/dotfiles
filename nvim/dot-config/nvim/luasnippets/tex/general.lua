-- Get helper functions
local helper = require("luasnip-helper-funcs")
local get_visual = helper.get_visual


local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta


return {
    s({ trig = "eq", dscr = "Expand into an equation environment" },
        fmta(
            [[
        \begin{equation}
            <>
        \end{equation}
        <>
        ]],
            { i(1), i(0) }
        )
    ),

    s({ trig = ';a', snippetType = "autosnippet" },
        {
            t("\\alpha"),
        }),

    s({ trig = ';b', snippetType = "autosnippet" },
        {
            t("\\beta"),
        }),

    s({ trig = 'tii' },
        fmta("\\textit{<>} <>",
            { d(1, get_visual), i(0) }
        )
    ),
}
