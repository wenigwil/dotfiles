vim.opt_local.shiftwidth = 4
vim.opt_local.textwidth = 85


vim.opt_local.spelllang = "en"
vim.opt_local.spell = true
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = true


local function exit_handler(success, error)
    return function(_, exit_code, _)
        if exit_code == 0 then
            vim.api.nvim_echo({ { success, 'DiagnosticOk' } }, true, {})
        else
            vim.api.nvim_echo({ { error .. exit_code, 'DiagnosticError' } }, true, {})
        end
    end
end

function texdoc_build_main(main_filename)
    local working_dir = vim.uv.cwd()
    local main_file = vim.fs.joinpath(working_dir, main_filename)
    local output_dir = vim.fs.joinpath(working_dir, "out")
    local aux_dir = vim.fs.joinpath(working_dir, "aux")

    if not vim.uv.fs_stat(main_file) then
        return vim.api.nvim_echo({ { "✘  main.tex does not exist!", "DiagnosticError" } }, true, {})
    end

    local command = "latexmk -halt-on-error -view=pdf -pdflua "
        .. "-outdir=" .. output_dir .. " "
        .. "-auxdir=" .. aux_dir .. " "
        .. main_file

    vim.api.nvim_echo({ { '↻  Compiling LaTeX document', 'DiagnosticWarn' } }, true, {})
    vim.fn.jobstart(command, {
        detach = true,
        on_exit = exit_handler('✔  LaTeX compilation successful!', '✘  Error compiling LaTeX document!. Exit Code: ')
    })
end

function texdoc_clean(main_filename)
    local working_dir = vim.uv.cwd()
    local main_file = vim.fs.joinpath(working_dir, main_filename)
    local output_dir = vim.fs.joinpath(working_dir, "out")
    local aux_dir = vim.fs.joinpath(working_dir, "aux")

    local command = "latexmk -c -pdflua "
        .. "-outdir=" .. output_dir .. " "
        .. "-auxdir=" .. aux_dir .. " "
        .. main_file

    vim.api.nvim_echo({ { '󰿞  Cleaning LaTeX files', 'DiagnosticWarn' } }, true, {})
    vim.fn.jobstart(command, {
        detach = true,
        on_exit = exit_handler('✔  Cleaning successful!', '✘ Error cleaning auxiliary files!. Exit Code: ')
    })
end

function texdoc_view_main(mainpdf_filename)
    local working_dir = vim.uv.cwd()
    local output_dir = vim.fs.joinpath(working_dir, "out")
    local pdf_file = vim.fs.joinpath(output_dir, mainpdf_filename)

    local command = "zathura " .. pdf_file .. " &"
    vim.api.nvim_echo({ { '   Opening PDF', 'DiagnosticWarn' } }, true, {})
    vim.fn.jobstart(command, {
        detach = true,
        on_exit = exit_handler('✔  PDF opened!', '✘  Error opening PDF file!. Exit Code: ')
    })
end

-- Keymaps for the function from above
vim.keymap.set({ 'n' }, "<F1>", function()
    -- Save before anything
    vim.cmd("write")
    texdoc_build_main("main.tex")
end)

vim.keymap.set({ 'n' }, "<F2>", function()
    -- Save before anything
    vim.cmd("write")
    texdoc_clean("main.tex")
end)

vim.keymap.set({ 'n' }, "<F3>", function()
    texdoc_view_main("main.pdf")
end)
