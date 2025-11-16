require("config.lazy")

-- General LSP-config for all clients go here
require("general-lsp")

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"



vim.api.nvim_set_keymap("n", "`", "^", { noremap = true })
vim.keymap.set("n", '<c-s-h>', ":wincmd 4 < <CR>")
vim.keymap.set("n", '<c-s-l>', ":wincmd 4 > <CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<c-q>", ":wincmd q<CR>")
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when copying text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
