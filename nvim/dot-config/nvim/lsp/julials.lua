local capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItems = capabilities.textDocument.completion.completionItem

capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
            end)(),
        },
    },
}

completionItems = {
    snippetSupport = true,
    preselectSupport = true,
    tagSupport = { valueSet = { 1 } },
    deprecatedSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    commitCharactersSupport = true,
    resolveSupport = {
        properties = { "documentation",
            "detail",
            "additionalTextEdits"
        },
    },
    documentationFormat = { 'markdown' },
}

return {
}
