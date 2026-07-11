vim.opt_local.shiftwidth = 4
vim.opt_local.textwidth = 85


vim.opt_local.formatoptions:append('o')
vim.opt_local.formatoptions:append('r')
vim.opt_local.formatoptions:append('j')
vim.opt_local.formatoptions:append('a')
vim.opt_local.formatoptions:append('w')


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

local function texdoc_build_main(main_filename)
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

local function texdoc_clean(main_filename)
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

local function texdoc_view_main(mainpdf_filename)
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


local function texlog_filter(mainlog_filename)
    local working_dir = vim.uv.cwd()
    local aux_dir = vim.fs.joinpath(working_dir, "aux")
    local mainlog_file = vim.fs.joinpath(aux_dir, mainlog_filename)

    local command = "texlogfilter " .. mainlog_file
        -- In case the removal of colors is important
        -- .. " | "
        -- .. " sed -E \'s/\\x1B\\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g\' "
        .. " > "
        .. mainlog_file .. ".filtered"

    vim.api.nvim_echo({ { '  Filtering ' .. mainlog_filename .. '...', 'DiagnosticWarn' } }, true, {})
    local jobid = vim.fn.jobstart(command, {
        detach = true,
        on_exit = exit_handler('✔  ' .. mainlog_filename .. ' filtered successfully!',
            '✘ Error Filtering ' .. mainlog_filename .. '!. Exit Code: ')
    })
    vim.fn.jobwait({ jobid })
end


-- IDEA for improving upon this:
-- For now I open a new window and receive only then the most updated version
-- of the filtered log. If there is another compile with a window alread opened, the
-- filtered log and more importantly the window itself will not be
-- updated/resized. To get the most updated log I will have to close and reopen,
-- which is fine for now.
-- The idea for the future is that upon opening the window for the first time,
-- F2 is remapped to a function that does a window resize and buffer refresh. I
-- can see that the window resize will be easy but the buffer refresh will be
-- tricky as the buffer displayed is not reading from the file anymore after the
-- invocation of nvim_open_term(). Maybe there is a way of only opening a
-- terminal and sending the filtered log with the ANSI termcodes into it with
-- vim.fn.chansend. The only tricky thing there might be correct EOF character
-- and also the escape sequence in the termcodes themselves. File checks would
-- also be a good idea for gracefully failing. This could also be great for
-- viewing compile logs when working with C++, Fortran or similar.
local function texlog_view(mainlog_filename)
    local aux_dir = vim.fs.joinpath(vim.uv.cwd(), "aux")
    local mainlog_file = vim.fs.joinpath(aux_dir, mainlog_filename)

    -- We have to do some magic to get the necessary height and widht of the
    -- filtered log for perfectly match
    local cmd_filtered_log_height = { "gawk", 'END{print NR}', mainlog_file .. ".filtered" }
    local cmd_filtered_log_width = { "gawk",
        'BEGIN {temp=0} {if (temp<length) {temp=length}} END {print temp}',
        mainlog_file .. ".filtered" }
    local obj = vim.system(cmd_filtered_log_height, { text = true }):wait()
    local height = tonumber(obj.stdout)
    local obj = vim.system(cmd_filtered_log_width, { text = true }):wait()
    local width = tonumber(obj.stdout)
    local current_height = vim.api.nvim_win_get_height(0)
    local bufnr = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_open_win(bufnr, true, {
        anchor = "SW",
        border = "rounded",
        relative = "editor",
        row = current_height,
        col = 5,
        title = "texlogfilter",
        title_pos = "center",
        width = width + 2,
        height = height,
    })
    vim.cmd.edit(mainlog_file .. ".filtered")

    -- Colorize by interpreting ANSI Termcodes
    vim.api.nvim_open_term(0, {})
end

vim.keymap.set({ 'n' }, "<F2>", function()
    texlog_filter("main.log")
    texlog_view("main.log")
end)

-- Keymaps for the function from above
vim.keymap.set({ 'n' }, "<F1>", function()
    -- Save before anything
    vim.cmd("write")
    texdoc_build_main("main.tex")
end)



vim.keymap.set({ 'n' }, "<F3>", function()
    texdoc_view_main("main.pdf")
end)

vim.keymap.set({ 'n' }, "<F5>", function()
    -- Save before anything
    vim.cmd("write")
    texdoc_clean("main.tex")
end)
