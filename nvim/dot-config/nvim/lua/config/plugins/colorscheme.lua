return {
    "folke/tokyonight.nvim",
    config = function()
        require('tokyonight').setup {
            style = "moon",
            transparent = false,
            terminal_colors = true,
            styles = {
                functions = {
                    bold = true,
                    italic = true
                },
                keywords = {
                    italic = true
                },
                comments = {
                    italic = true
                },
            },
            dim_inactive = false,
        }
        vim.cmd.colorscheme "tokyonight"
    end
}
