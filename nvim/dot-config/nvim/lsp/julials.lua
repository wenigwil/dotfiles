local function create_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

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

    capabilities.textDocument.completion.completionItem = {
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

    return capabilities
end

local julia_lspenv_path = vim.fs.joinpath('/home/wenigwil/opt/', 'LanguageServerEnv.jl')
local julia_runlsp_file = vim.fs.joinpath(julia_lspenv_path, "lspconfig-runlsp.jl")

return {
    cmd          = { 'julia', '--project=' .. julia_lspenv_path, julia_runlsp_file },
    filetypes    = { "julia", "jl" },
    root_markers = { ".git", "Project.toml", "Manifest.toml", "JuliaProject.toml" },
    capabilities = create_capabilities()
}
