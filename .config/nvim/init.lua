--[[
-- Basic settings
--]]

-- Show line number for current line and relative line numbers for all of the
-- other lines. (See :h number_relativenumber)
vim.o.number = true
vim.o.relativenumber = true

-- New lines copy previous line's indentation
vim.o.autoindent = true

-- Make <Tab> key insert spaces
vim.o.expandtab = true

-- Width of tab 
vim.o.tabstop = 4

-- Width of indentitation steps  (using >> and <<)
vim.o.shiftwidth = vim.o.tabstop

-- In insert mode, make <BS> behave normally
vim.o.backspace = 'indent,eol,start'

-- When 'ignorecase' and 'smartcase' are both enabled, search ignores case
-- except when the search pattern contains an uppercase letter.
vim.o.ignorecase = true
vim.o.osmartcase = true

-- Wait for <CR> before jumping to results
vim.o.incsearch = false

-- Turn off search highlighting
vim.o.hlsearch = false

-- Use [ripgrep](https://github.com/BurntSushi/ripgrep) as the grep program 
vim.o.grepprg='rg --vimgrep --no-column'

-- Use + register, the register tied to the sytem clipboard, as the unnamed
-- register. In other words, yanks and pastes will come from the system
-- clipboard.
-- vim.o.clipboard = ',unnamedplus'

-- Disable mouse right-click menu (:help default-mouse)
vim.o.mouse = false

--[[
-- Key mappings
--]]

-- Set leader key for key mappings
vim.g.mapleader = ","

-- Window navigation
for _, key in pairs({'j', 'k', 'h', 'l'}) do
    vim.keymap.set('n', '<C-' .. key .. '>', '<C-w>' .. key)
end

-- Tabs 

-- Tab navigation keys
vim.keymap.set('n', '<S-h>', ':tabprev<Enter>')
vim.keymap.set('n', '<S-h>', ':tabnext<Enter>')

vim.keymap.set('n', '<Leader>tc', ':tabclose<Enter>')
vim.keymap.set('n', '<Leader>tn', ':tabnew<Enter>')

vim.keymap.set('n', 'x', function() print("real lua function") end)
vim.keymap.set('n', "<Leader>z", function() print("real lua function") end)

-- Tab duplication
vim.keymap.set('n', '<Leader>td', function()
    local cursor_pos = vim.fn.getpos('.')
    vim.cmd.tabnew {
        args = { vim.fn.expand('%') }
    }
    vim.fn.setpos('.', cursor_pos)
end)

-- Closes all the tabs in a particular diretion
--- @param direction number
local function close_tabs_in_direction_tabs(direction)
    if (direction == 0) then
        return
    end
    local cur_tab_nr = vim.fn.tabpagenr()
    local close_count = 0
    local next_tab
    if (direction > 0) then
        close_count = cur_tab_nr - vim.fn.tabpagenr('$')
        next_tab = '+'
    elseif (direction < 0) then
        close_count = cur_tab_nr - 1
        next_tab = '-'
    end
    while close_count > 0 do
        vim.cmd.tablclose(next_tab)
        close_count = close_count - 1
    end
end

-- Close tabs to the right of the current tab
vim.keymap.set('n', '<Leader>tcr', function()
    close_tabs_in_direction_tabs(1)
end)

-- Close tabs to the left of the current tab
vim.keymap.set('n', '<Leader>tcr', function()
    close_tabs_in_direction_tabs(-1)
end)

-- Quickfix window
vim.keymap.set('n', '<Leader>co', ':copen<Enter>')
vim.keymap.set('n', '<Leader>cc', ':cclose<Enter>')

-- Grep matches appear in the quick fix window. With this mapping we are able
-- to yank just the matching part.
vim.keymap.set(
    'n',
    '<Leader>yy',
    function()
        vim.fn.execute('normal yy')
        if vim.bo.filetype == 'qf' then
            local matches = vim.fn.matchlist(vim.fn.trim(vim.fn.getreg()), [[^.\{1,}|\d\{1,\}|\s\(.\{1,}\)$]])
            vim.fn.setreg('', matches[2] .. '\n')
        end
    end
)
