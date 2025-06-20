return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    theme = 'ivy',
                },
            },
            extensions = {
                fzf = {}
            },
            defaults = {
                file_ignore_patterns = {
                    -- Ignoring pdfs to avoid freeze
                    "%.pdf"
                },
            },
        }
        -- This is just for making telescope search faster
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('nerdy')
        local tc_builtin = require('telescope.builtin')


        vim.keymap.set("n", "<space>sh", tc_builtin.help_tags)

        vim.keymap.set("n", "<space>sn", function()
            tc_builtin.find_files({
                cwd = vim.fn.stdpath('config')
            })
        end)

        vim.keymap.set("n", "<space>sf", function()
            tc_builtin.find_files()
        end)

        vim.keymap.set("n", "<space>sg", function()
            tc_builtin.live_grep({
                -- Search for types with
                -- "rg --type-list | less"
                type_filter = "fortran"
            })
        end)

        vim.keymap.set("n", "<space>sb", function()
            tc_builtin.current_buffer_fuzzy_find()
        end)

        vim.keymap.set("n", "<space>nf", function()
            require('telescope').extensions.nerdy.nerdy()
        end)

        vim.keymap.set("n", "<space>sd", function()
            tc_builtin.find_files()
        end)

        vim.keymap.set("n", "<space>sp", function()
            tc_builtin.find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end)

        -- Go list references
        vim.keymap.set("n", "<space>gr", function()
            tc_builtin.lsp_references()
        end)

        -- Go list definitions
        vim.keymap.set("n", "<space>gd", function()
            tc_builtin.lsp_definitions({
                jump_type = "never"
            })
        end)

        -- Go list implementations
        vim.keymap.set("n", "<space>gi", function()
            tc_builtin.lsp_implementations({
                jump_type = "never"
            })
        end)
    end
}
