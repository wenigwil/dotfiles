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

        vim.keymap.set("n", "<space>sh", require('telescope.builtin').help_tags)
        vim.keymap.set("n", "<space>sn", function()
            require('telescope.builtin').find_files({
                cwd = vim.fn.stdpath('config')
            })
        end)


        vim.keymap.set("n", "<space>nf", function()
            require('telescope').extensions.nerdy.nerdy()
        end)
        vim.keymap.set("n", "<space>sd", function()
            require('telescope.builtin').find_files({
                cwd = "/home/wenigwil/Documents"
            })
        end)
        vim.keymap.set("n", "<space>sp", function()
            require('telescope.builtin').find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end)
    end
}
