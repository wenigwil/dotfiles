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
                },
            },
            dim_inactive = false,
        }
        vim.cmd.colorscheme "tokyonight"
    end,
}
