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

    -- Bold
    s({ trig = 'bo' },
        fmta('**<>** <>',
            { d(1, get_visual), i(0) })
    ),

    -- Italics
    s({ trig = 'it' },
        fmta('*<>* <>',
            { d(1, get_visual), i(0) })
    ),

    -- Bold+Italics
    s({ trig = 'bi' },
        fmta('***<>*** <>',
            { d(1, get_visual), i(0) })
    ),

    -- Link
    s({ trig = "ff", snippetType = "autosnippet" },
        fmta("[<>](<> \"<>\") <>",
            { d(1, get_visual), i(2, "URL"), i(3, "TITLE"), i(0) })
    ),

}
