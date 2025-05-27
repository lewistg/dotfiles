-- Grep matches appear in the quick fix window. With this mapping we are able
-- to yank just the matching part.
vim.keymap.set(
    'n',
    '<Leader>yy',
    function()
        vim.fn.execute('normal yy')
        local matches = vim.fn.matchlist(vim.fn.trim(vim.fn.getreg()), [[^.\{1,}|\d\{1,\}|\s\(.\{1,}\)$]])
        vim.fn.setreg('', matches[2] .. '\n')
    end
)
