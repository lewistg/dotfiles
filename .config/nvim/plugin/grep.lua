local function grep_visually_selected_text()
    local _, start_line, start_col = unpack(vim.fn.getpos("v"))
    local _, end_line, end_col = unpack(vim.fn.getpos("."))
    if (start_line ~= end_line) then
        return
    end

    local selected_text = vim.api.nvim_buf_get_text(
        0,
        start_line - 1,
        start_col - 1,
        end_line - 1,
        end_col,
        {}
    )

    -- Exit visual mode
    local escape_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(escape_key, "nx", false)

    vim.cmd.grep {
        args = selected_text,
        bang = true,
    }

    vim.cmd.copen()
end

vim.keymap.set('v', '<Leader>g', grep_visually_selected_text)
