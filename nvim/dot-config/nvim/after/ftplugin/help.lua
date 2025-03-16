vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    desc = 'Open any files of the type help vertically',
    group = vim.api.nvim_create_augroup('vert-open-help', { clear = true }),
    callback = function(args)
        if vim.o.filetype == 'help' then
            local buffer_number = args.buf
            local window_id = vim.fn.bufwinid(buffer_number)
            vim.fn.win_execute(window_id, 'wincmd L')
        end
    end,
})
