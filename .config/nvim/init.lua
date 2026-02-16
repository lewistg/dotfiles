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
vim.o.smartcase = true

-- Wait for <CR> before jumping to results
vim.o.incsearch = false

-- Turn off search highlighting
vim.o.hlsearch = false

-- Use [ripgrep](https://github.com/BurntSushi/ripgrep) as the grep program 
vim.o.grepprg='rg --vimgrep --no-column'

-- Disable mouse right-click menu (:help default-mouse)
vim.o.mouse = ""

require("config.keymaps")
