-- Set leader key for key mappings
vim.g.mapleader = ","

-- Clipboard copy/paste

-- See :help quoteplus
vim.keymap.set({'n', 'v'}, '<Leader>y', '"+y', {desc = "Yank to clipboard"})
vim.keymap.set({'n', 'v'}, '<Leader>p', '"+p', {desc = "Paste from clipboard"})

-- Window navigation

for _, key in pairs({'j', 'k', 'h', 'l'}) do
    vim.keymap.set('n', '<C-' .. key .. '>', '<C-w>' .. key)
end

-- Tabs

-- Tab navigation keys
vim.keymap.set('n', '<S-h>', ':tabprev<Enter>', {desc = "Go to the previous tab"})
vim.keymap.set('n', '<S-l>', ':tabnext<Enter>', {desc = "Go to the next tab"})

vim.keymap.set('n', '<Leader>tc', ':tabclose<Enter>', {desc = "Close the tab"})
vim.keymap.set('n', '<Leader>tn', ':tabnew<Enter>', {desc = "Open a new tab"})

-- Tab duplication
vim.keymap.set('n', '<Leader>td', function()
    local cursor_pos = vim.fn.getpos('.')
    vim.cmd.tabnew {
        args = { vim.fn.expand('%') }
    }
    vim.fn.setpos('.', cursor_pos)
end, {
    desc = "Open current pane in a new tab"
})

-- Closes all the tabs in a particular direction 
--- @param direction number
local function close_tabs_in_direction_tabs(direction)
    if (direction == 0) then
        return
    end
    local cur_tab_nr = vim.fn.tabpagenr()
    local close_count = 0
    local next_tab
    if (direction > 0) then
        close_count = vim.fn.tabpagenr('$') - cur_tab_nr
        next_tab = '+'
    elseif (direction < 0) then
        close_count = cur_tab_nr - 1
        next_tab = '-'
    end
    while close_count > 0 do
        vim.cmd.tabclose(next_tab)
        close_count = close_count - 1
    end
end

-- Close tabs to the right of the current tab
vim.keymap.set('n', '<Leader>tcr', function()
    close_tabs_in_direction_tabs(1)
end, {desc = "Close tabs to the right"})

-- Close tabs to the left of the current tab
vim.keymap.set('n', '<Leader>tcl', function()
    close_tabs_in_direction_tabs(-1)
end, {desc = "Close tabs to the left"})

-- Quickfix window
vim.keymap.set('n', '<Leader>co', ':copen<Enter>', {desc = "Open quickfix window"})
vim.keymap.set('n', '<Leader>cc', ':cclose<Enter>', {desc = "Close quickfix window"})
