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
        end,
    }
}
