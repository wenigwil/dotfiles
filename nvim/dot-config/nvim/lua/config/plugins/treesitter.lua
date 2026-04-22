return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function()
            local textobjects = require('nvim-treesitter-textobjects')
            local to_select = require('nvim-treesitter-textobjects.select')
            local to_move = require('nvim-treesitter-textobjects.move')
            local to_swap = require('nvim-treesitter-textobjects.swap')
            local treesitter = require('nvim-treesitter')

            treesitter.install({
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "bash",
                "julia",
            })


            textobjects.setup({
                move = {
                    set_jumps = true,
                },
                select = {
                    lookahead = true,
                }
            })


            -- Setting keymaps for code navigation
            -- Functions
            vim.keymap.set({ "x", "o" }, "af", function()
                to_select.select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                to_select.select_textobject("@function.outer", "textobjects")
            end)

            -- Calls
            vim.keymap.set({ "x", "o" }, "ac", function()
                to_select.select_textobject("@call.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                to_select.select_textobject("@call.inner", "textobjects")
            end)

            -- Loops
            vim.keymap.set({ "x", "o" }, "ar", function()
                to_select.select_textobject("@loop.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ir", function()
                to_select.select_textobject("@loop.inner", "textobjects")
            end)

            -- Parameters
            vim.keymap.set({ "x", "o" }, "aa", function()
                to_select.select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ia", function()
                to_select.select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]a", function()
                to_move.goto_next_start("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[a", function()
                to_move.goto_previous_start("@parameter.outer", "textobjects")
            end)

            vim.keymap.set("n", "<leader>sa", function()
                to_swap.swap_next("@parameter.inner", "textobjects")
            end)

            -- Local Scope
            vim.keymap.set({ "x", "o" }, "is", function()
                to_select.select_textobject("@local.scope", "local")
            end)
        end
    } }



-- x = visual
-- v = visual and select
-- n = normal
-- s = select
-- o = operator-pending
-- i = insert
-- l = insert, command-line and lang-arg
-- c = command-line
-- t = terminal
