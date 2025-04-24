return {
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            -- Glob pattern for finding and parsing shell script files in the workspace.
            -- Used by the background analysis features across files.

            -- Prevent recursive scanning which will cause
            -- issues when opening a file is directly in the
            -- home directory (e.g. ~/foo.sh).
            --
            -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
            shfmt = {
                languageDialect = "bash",
                simplifyCode = true,
                spaceRedirects = true,
                funcNextLine = true,
            },
        },
    },
    filetypes = { 'bash', 'sh' },
    single_file_support = true
}
