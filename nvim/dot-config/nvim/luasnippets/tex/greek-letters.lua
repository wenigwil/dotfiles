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

local get_greek = function(shortcut, letter)
    local greek_snip = s({
            trig = '(.*)' .. shortcut,
            wortTrig = false,
            regTrig = true,
            snippetType = "autosnippet",
            condition = helper.in_mathzone
        },
        {
            f(paste_capture1),
            t("\\" .. letter),
        })
    return greek_snip
end

return {
    get_greek(';a', "alpha"),
    get_greek(';b', "beta"),
    get_greek(';g', "gamma"),
    get_greek(';G', "Gamma"),
    get_greek(';d', "delta"),
    get_greek(';D', "Delta"),
    get_greek(';e', "varepsilon"),
    get_greek(';z', "zeta"),
    get_greek(';n', "eta"),
    get_greek(';t', "theta"),
    get_greek(';T', "Theta"),
    get_greek(';i', "iota"),
    get_greek(';k', "kappa"),
    get_greek(';l', "lambda"),
    get_greek(';L', "Lambda"),
    get_greek(';s', "sigma"),
    get_greek(';S', "Sigma"),
    get_greek(';S', "Sigma"),
    get_greek(';f', "phi"),
    get_greek(';F', "Phi"),
    get_greek(';c', "chi"),
    get_greek(';p', "psi"),
    get_greek(';P', "Psi"),
    get_greek(';o', "omega"),
    get_greek(';O', "Omega"),
}
