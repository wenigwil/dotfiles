return {
    "folke/tokyonight.nvim",
    config = function()
        require('tokyonight').setup {
            transparent = false,
            terminal_colors = true,
            styles = {
                functions = { bold = true },
            },
            dim_inactive = true,
        }
        vim.cmd.colorscheme "tokyonight"
    end,
}
