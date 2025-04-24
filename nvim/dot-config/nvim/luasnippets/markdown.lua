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


return {

    -- Bold
    s({ trig = 'bo' },
        fmta('**<>**<>',
            { d(1, get_visual), i(0) })
    ),

    -- Italics
    s({ trig = 'it' },
        fmta('*<>*<>',
            { d(1, get_visual), i(0) })
    ),

    -- Bold+Italics
    s({ trig = 'boit' },
        fmta('***<>***<>',
            { d(1, get_visual), i(0) })
    ),

    -- Crossed out
    s({ trig = 'co' },
        fmta('~~<>~~<>',
            { d(1, get_visual), i(0) })
    ),

    -- Promt
    s({ trig = 'p' },
        fmta('`<>`<>',
            { d(1, get_visual), i(0) })
    ),

    -- Link with mask
    s({ trig = "ff" },
        fmta("[<>](<>)<>",
            { d(1, get_visual), i(2, "URL"), i(0) })
    ),

    -- Link with mask and title
    s({ trig = "fff" },
        fmta("[<>](<> \"<>\")<>",
            { d(1, get_visual), i(2, "URL"), i(3, "TITLE"), i(0) })
    ),

    -- Task
    s({ trig = "do" },
        fmta("- [ ] <>",
            { d(1, get_visual) })
    ),

    -- Picture with description and title
    s({ trig = "pic" },
        fmta("![<>](<> \"<>\")<>",
            { d(1, get_visual), i(2, "URL"), i(3, "TITLE"), i(0) })
    ),


    -- Codeblock
    s(
        { trig = "cb" },
        fmta(
            [[
        ~~~<>
        <>
        ~~~
        <>
        ]],
            { i(1), i(2), i(0) }
        )
    ),

}
