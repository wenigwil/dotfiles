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

vim.opt_local.shiftwidth = 4
vim.opt_local.formatoptions:append('t')
vim.opt_local.formatoptions:append('w')
vim.opt_local.formatoptions:append('a')
vim.opt_local.formatoptions:append('n')
vim.opt_local.textwidth = 85

vim.b.miniindentscope_disable = true

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
