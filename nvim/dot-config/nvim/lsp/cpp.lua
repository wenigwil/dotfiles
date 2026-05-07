return {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = {
        '.git',
        '.clangd',
        '.clang-format',
        '.clang-tidy',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },


}
