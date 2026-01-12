return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, bufnr)
                        -- Get rid of the .. folder
                        local m = name:match("^%.%.$")
                        return m ~= nil
                    end,
                }
            })

            vim.keymap.set("n", "-", "<cmd>Oil<CR>")
        end
    }
}
