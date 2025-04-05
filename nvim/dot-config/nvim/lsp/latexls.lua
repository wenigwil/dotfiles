return {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'plaintex', 'bib' },
    root_markers = { '.git', '.latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml' },
    single_file_support = true,
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = 'latexmk',
          args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
          onSave = true,
          forwardSearchAfter = false,
        },
        forwardSearch = {
          executable = nil,
          args = {},
        },
        chktex = {
          onOpenAndSave = false,
          onEdit = false,
        },
        diagnosticsDelay = 300,
        latexFormatter = 'latexindent',
        latexindent = {
          ['local'] = nil, -- local is a reserved keyword
          modifyLineBreaks = false,
        },
        bibtexFormatter = 'texlab',
        formatterLineLength = 80,
      },
    },
  },
  commands = {
    TexlabBuild = {
      client_with_fn(buf_build),
      description = 'Build the current buffer',
    },
    TexlabForward = {
      client_with_fn(buf_search),
      description = 'Forward search from current position',
    },
    TexlabCancelBuild = {
      client_with_fn(buf_cancel_build),
      description = 'Cancel the current build',
    },
    TexlabDependencyGraph = {
      client_with_fn(dependency_graph),
      description = 'Show the dependency graph',
    },
    TexlabCleanArtifacts = {
      client_with_fn(command_factory('Artifacts')),
      description = 'Clean the artifacts',
    },
    TexlabCleanAuxiliary = {
      client_with_fn(command_factory('Auxiliary')),
      description = 'Clean the auxiliary files',
    },
    TexlabFindEnvironments = {
      client_with_fn(buf_find_envs),
      description = 'Find the environments at current position',
    },
    TexlabChangeEnvironment = {
      client_with_fn(buf_change_env),
      description = 'Change the environment at current position',
    },
}
