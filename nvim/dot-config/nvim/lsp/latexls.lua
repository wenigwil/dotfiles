return {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'plaintex', 'bib' },
    root_markers = { '.git', '.latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml' },
    single_file_support = true,
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                onSave             = false,
                forwardSearchAfter = false,
                filename           = "main.tex",
            },
            forwardSearch = {
                executable = 'zathura',
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            completion = {
                matcher = "fuzzy",
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = false,
                additionalArgs = { '--verbosity=0' },
            },
            diagnosticsDelay = 100,
            latexFormatter = 'latexindent',
            latexindent = {
                -- Ensure perl-yaml-tiny and perl-file-homedir are installed!
                -- Otherwise latexindent will not work properly
                modifyLineBreaks = true,
                ["local"] = ".formatter.yaml",
            },
            bibtexFormatter = 'latexindent',
        },
    },
}
