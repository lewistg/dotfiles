local function get_session_file()
    local temp_dir = vim.fn.stdpath("cache")
    return temp_dir .. "/Session.vim"
end

vim.api.nvim_create_user_command(
    "SaveSession",
    function()
        vim.cmd.mksession(get_session_file())
    end,
    {}
)

vim.api.nvim_create_user_command(
    "OpenSavedSession",
    function()
        local session_file = get_session_file()
        vim.print(session_file)
        if vim.fn.filereadable(session_file) then
            vim.cmd.source(session_file)
        else
            vim.notify("No session file found.", vim.log.levels.WARN)
        end
    end,
    {}
)
