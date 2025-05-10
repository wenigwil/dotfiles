-- Get helper functions
local helper = require("luasnip-helper-funcs")
local get_visual = helper.get_visual


local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt


return {

    -- simple function
    s(
        { trig = "ff" },
        fmta(
            [[
        function <>(<>)
            <>
        end
        <>
        ]],
            { i(1, "NAME"), i(2), i(3), i(0) }
        )
    ),

    -- docstring
    s(
        { trig = "doc" },
        fmta(
            [[
        """
        <>
        """
            ]],
            { i(0, "DOCUMENTATION") }
        )
    )

}
