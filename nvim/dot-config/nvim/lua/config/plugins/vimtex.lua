-- In this file you should put all global VimTeX
-- options. The idea is to use this file for all
-- VimTeX-configs that should be set beforehand!
--
-- Use ftplugin/tex.lua for configs specific to
-- a tex-buffer.
return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
            vim.g.vimtex_view_general_viewer = 'okular'
        end
    }
}
