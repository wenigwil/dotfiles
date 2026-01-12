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
-- Normal mode window switching
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
-- Insert mode window switching
vim.keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l")
-- Terminal mode window switching
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
-- Escape from everything
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc>', "<C-\\><C-N>")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when copying text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


-- Useful terminal shortcuts
vim.keymap.set('n', '<space><C-M>', function()
    local bufnr = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_open_win(bufnr, true, { vertical = true, split = "right", win = -1 })
    vim.cmd.term()
    local cwd = vim.uv.cwd()
    print(cwd)
    local chanid = vim.bo[bufnr].channel
    vim.api.nvim_chan_send(chanid, "cd " .. cwd .. "; clear\r")
end)

vim.keymap.set('n', '<A-q>', function()
    -- Detect the buffer type

    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    if vim.bo[bufnr].buftype == "terminal" then
        -- Get the channelid to send input
        local chanid = vim.bo[bufnr].channel
        -- Send it to the terminal
        vim.api.nvim_chan_send(chanid, "exit\r")
    else
        vim.api.nvim_win_close(0, false)
    end
end)
