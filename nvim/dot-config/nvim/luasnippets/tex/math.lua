-- Get helper functions
local helper = require("luasnip-helper-funcs")
local get_visual = helper.get_visual
local paste_capture1 = helper.paste_capture1

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s(
        {
            trig = "uu",
            wordTrig = false,
            regTrig = true,
            snippetType = "autosnippet",
            condition = helper.in_mathzone
        },
        fmta(
            "<>_{<>} <>",
            {
                f(paste_capture1),
                i(1),
                i(2),
            }
        )
    ),
}
