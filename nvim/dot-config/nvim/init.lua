require("config.lazy")


vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when copying text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
