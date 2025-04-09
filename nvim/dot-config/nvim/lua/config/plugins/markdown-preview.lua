return {
    -- "iamcco/markdown-preview.nvim",
    -- build = "cd app && npm install",
    -- init = function()
    --     vim.g.mkdp_filetypes = { "markdown" }
    -- end,
    -- config = function()
    --     vim.keymap.set("n", "<Leader>mp", "<Plug>MarkdownPreview", { desc = "Markdown Preview" })
    --     vim.g.mkdp_theme = 'light'
    --     -- Unfortunately vimscript has to be introduced to configure this
    --     vim.cmd([[do FileType]])
    --     vim.cmd([[
    --          function OpenMarkdownPreview (url)
    --             let cmd = "firefox --new-window " . shellescape(a:url) . " &"
    --             silent call system(cmd)
    --          endfunction
    --       ]])
    --     vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    -- end,
}
