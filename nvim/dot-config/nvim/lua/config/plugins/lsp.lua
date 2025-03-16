return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            require("lspconfig").lua_ls.setup {}
            require("lspconfig").bashls.setup {
                handlers = {
                    ["textDocument/publishDiagnostics"] = vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics, {
                            -- Set the virtual text aligned
                            virtual_text = {
                                virt_text_win_col = 55,
                            },
                        }
                    ),
                }

            }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end
            })
        end -- CONFIG LSP END
    }
}
