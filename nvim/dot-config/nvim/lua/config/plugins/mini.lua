return {
    {
        'echasnovski/mini.nvim',
        config = function()
            -- Configuring the STATUS LINE of mini.nvim
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = true }

            -- Configuring the MOVE FUNCTIONALITY of mini.nvim
            local move = require 'mini.move'
            -- Building a table for the options
            local move_setup = {
                mappings = {
                    left = '<M-h>',
                    right = '<M-l>',
                    down = '<M-j>',
                    up = '<M-k>'
                },
                options = {
                    reindent_linewise = false,
                }
            }
            move.setup(move_setup)

            -- Configuring the SURROUND of mini.nvim
            -- USEFUL KEYBINDS:
            -- ----------------
            -- saiw) - add (sa) for inner word (iw) parenthesis )
            -- sdb OR srb - delete OR replace surrounding bracket
            -- sdq OR srq - delete OR replace surrounding quotes
            local surround = require('mini.surround')
            surround.setup()

            -- Configuring the a/i-TEXTOBJECTS of mini.nivm
            -- USEFUL KEYBINDS:
            -- ----------------
            -- Select the previous <textobject> when some
            -- textobject is currently selected
            -- inner: il<text-object>
            -- outer: al<text-object>
            --
            -- Select the next <textobject> when some
            -- textobject is currently selected
            -- inner: in<text-object>
            -- outer: an<text-object>
            local ai = require("mini.ai")
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            local ai_setup = {
                search_method = 'cover_or_next',
                custom_textobjects = {
                    o = spec_treesitter({
                        a = '@conditional.outer',
                        i = '@conditional.inner',
                    }),
                    f = spec_treesitter({
                        a = '@function.outer',
                        i = '@function.inner'
                    }),
                    r = spec_treesitter({
                        a = '@loop.outer',
                        i = '@loop.inner'
                    }),
                    a = spec_treesitter({
                        a = '@parameter.outer',
                        i = '@parameter.inner'
                    }),
                    c = spec_treesitter({
                        a = '@call.outer',
                        i = '@call.inner',
                    }),
                }
            }
            ai.setup(ai_setup)
        end,
    }
}
