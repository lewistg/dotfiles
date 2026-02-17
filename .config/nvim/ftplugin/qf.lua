-- Grep matches appear in the quick fix window. With this mapping we are able
-- to yank just the matching part.
vim.keymap.set(
    'n',
    '<Leader>yy',
    function()
        local _, line_index = vim.fn.getpos(".")
        local selected_item = vim.fn.getqflist({items = true, idx = line_index}).items[1]
        if selected_item.valid then
            vim.fn.setreg('', selected_item.text .. '\n')
        end
    end
)
