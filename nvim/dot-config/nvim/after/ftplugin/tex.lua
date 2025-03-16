-- Use this file for configuration that
-- will be specific to tex-buffers.
-- "<plug>(vimtex-compile-ss)"
vim.keymap.set({ 'n', 'i' }, "<F1>", function()
    vim.cmd("stopinsert")
    vim.cmd("write")
    vim.cmd("VimtexCompileSS")
end)

vim.keymap.set({ 'v' }, "<F1>", function()
    vim.api.nvim_input("<Esc>")
    vim.cmd("VimtexCompileSS")
end)

vim.keymap.set({ 'n' }, "<F2>", function()
    vim.cmd(":VimtexView")
end)
