-- Overridiing the filetype detection for notes from the
-- application calcurse. Very nice calendar btw
vim.filetype.add({
    pattern = {
        -- If the priority is not high enough it will be
        -- detected with filetype "conf"
        -- For pattern testing go to https://iamreiyn.github.io/lua-pattern-tester/
        ['.*/calcurse%-note%.[%w]+'] = { 'markdown', { priority = 100 } },
    }
})
