-- Replaces the currently visually selected text with the contents of the unnamed register
local function substitute_visual_selection_with_unnamed_register()
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

    local last_yanked_text = vim.fn.getreg()

    -- Exit visual mode
    local escape_key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(escape_key, "nx", false)

    vim.cmd(string.format("%%s/%s/%s/gc", selected_text[1], last_yanked_text))
end

vim.keymap.set('v', '<Leader>sy', substitute_visual_selection_with_unnamed_register)
