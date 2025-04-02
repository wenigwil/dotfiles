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
        end,
    }
}
