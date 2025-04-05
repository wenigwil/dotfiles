-- General LSP client config that will be applied
-- to all clients

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { '.git' },
    -- Format on writing
    on_attach = function(client, bufnr)
        if not client then return end

        -- Automatic formatting on save
        if client:supports_method('textDocument/formatting', bufnr) then
            -- Just be sure and put it in its own group so commands dont pile up
            local format_augroup_id = vim.api.nvim_create_augroup('FormatOnSave', {
                clear = true,
            })
            -- Turns out it is quite important to make the autocmd buffer-local
            vim.api.nvim_create_autocmd('BufWritePre', {
                -- Prevent pile up
                group = format_augroup_id,
                -- Buffer-local
                buffer = bufnr,
                -- Format pls only this buffer plsss
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                end,
            })
        end

        if client.supports_method('textDocument/publishDiagnostics') then
            local client_namespace = vim.lsp.diagnostic.get_namespace(client.id)
            vim.diagnostic.config({
                    virtual_text  = true,
                    virtual_lines = false,
                    severity_sort = true,
                },
                client_namespace)
        end
    end,
})

vim.lsp.enable({ "luals" })
