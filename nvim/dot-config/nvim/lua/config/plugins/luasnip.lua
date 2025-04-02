return {
    "L3MON4D3/LuaSnip",
    version = "v2.3.0",
    build = "make install_jsregexp",
    config = function()
        -- Specify the directory in which my snippets reside
        require("luasnip.loaders.from_lua").load({
            paths = { "~/.config/nvim/luasnippets" },
        })
        -- Adhere to the standard name conventions
        local ls = require("luasnip")

        -- Set some initals
        require("luasnip").config.set_config({
            -- Enable autotriggered snippets
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })

        -- Expand if expandable or jump
        vim.keymap.set("i", "<Tab>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                else
                    -- Feed the Tab Key back else
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
                        "n",
                        false)
                end
            end,
            { silent = true })

        -- Jump if jumpable in Visual Mode
        vim.keymap.set({ "s" }, "<Tab>", function()
                if ls.jumpable(1) then
                    ls.jump(1)
                else
                    -- Feed the Tab Key back else
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
                        "n",
                        false)
                end
            end,
            { silent = true })

        -- Jump back if jumpable
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end,
            { silent = true })


        -- Reload snippets keymap
        vim.keymap.set('n', '<Leader>ls',
            '<Cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnippets/"})<CR>')
    end,

}
