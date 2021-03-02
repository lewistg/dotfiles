"
" Basic settings
"

" Show line numbers
set number
" New lines copy previous line's indentation
set autoindent
" Make <Tab> key insert spaces
set expandtab
" Sets how many spaces equal a tab
set tabstop=4
" Width of indentation steps (using >> and <<)
set shiftwidth=4
" In insert mode, make <BS> behave normally
set backspace=indent,eol,start
" When 'ignorecase' and 'smartcase' are both enabled, search ignores case
" except when the search pattern contains an uppercase letter.
set ignorecase
set smartcase
" Enable syntax highlighting
syntax on
" Set custom key mapping leader key
let mapleader = ","
colorscheme myevening

"
" Relative line number toggling
" (See:
" https://jeffkreeftmeijer.com/vim-number/#automatic-toggling-between-line-number-modes)
"
augroup RelativeLineNumbers
  autocmd!
  " Show relative line numbers for the current buffer if in normal or visual
  " modes. (Note: Because 'number' is set as well, the current line shows
  " its absolute line number.)
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  " Show absolute line numbers in insert mode and for buffers besides the
  " one with the cursor.
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Highlight the current line for the current buffer 
augroup CursorLine
  autocmd! 
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
augroup END

"
" Split window navigation 
"

" Move to the buffer below
nnoremap <C-j> <C-W>j
" Move to the buffer above
nnoremap <C-k> <C-W>k
" Move to the buffer to the left
nnoremap <C-h> <C-W>h
" Move to the buffer to the right
nnoremap <C-l> <C-W>l

"
" Tab navigation
"

" Move to the tab to the left
nnoremap <S-h> :tabprevious<Enter>
" Move to the tab to the right
nnoremap <S-l> :tabnext<Enter>

"
" Tab management
"

" Create a new tab
nnoremap <Leader>tn :tabnew<Enter>
" Close the current tab
nnoremap <Leader>tc :tabclose<Enter>
" Close all tabs right of the current one
function! s:closeTabsToTheRight()
    let currTabNr = tabpagenr()

    let tabInfo = gettabinfo()
    let lastTabNr = tabInfo[len(tabInfo) - 1]['tabnr']

    let numTabsToRight = lastTabNr - currTabNr
    let i = 0
    while i < numTabsToRight
        tabclose $
        let i = i + 1
    endwhile
endfunction
nnoremap <Leader>tcr :call <SID>closeTabsToTheRight()<Enter>
" Close all tabs left of the current one
function! s:closeTabsToTheLeft()
    let numTabsToLeft = tabpagenr() - 1
    let i = 0
    while i < numTabsToLeft
        tabclose 1
        let i = i + 1
    endwhile
endfunction
nnoremap <Leader>tcl :call <SID>closeTabsToTheLeft()<Enter>

"
" Status line
"

" Filename relative to CWD
set statusline=%f       
" Modified [+]
set statusline+=\ %m    
" [RO]
set statusline+=\ %r    
" Start left justify
set statusline+=%=      
" [<filetype>]
set statusline+=\ %y      
" <line>:<column>
set statusline+=\ %l:%c 

"
" Quickfix
"

" Open the quickfix window
nnoremap <Leader>co :copen<Enter>
nnoremap <Leader>cc :cclose<Enter>

" Load built-in plugin for filtering quickfix entries
packadd cfilter 

"
" Editing .vimrc
"

" Source the current file. Helpful for testing functions or new config.
nnoremap <Leader>s :source %<Enter>
" Open .vimrc file
nnoremap <Leader>evc :e ~/.vimrc<Enter>

"
" Session management
"

" Quickly save the current session
let g:sessions_dir = "~/.vim/sessions/"
let g:default_filename = "Session.vim"
command! SaveSession :exec "mks! " . <SID>GetSessionName()
command! OpenSavedSession :exec "source " . <SID>GetSessionName()
function! s:GetSessionName() abort
    let l:branch_name = trim(system('git branch --show-current'))
    if v:shell_error == 0
        return g:sessions_dir . l:branch_name . ".vim"
    else
        return g:sessions_dir . g:default_filename . ".vim"
    endif
endfunction

"
" grep
" 

" Use [ripgrep](https://github.com/BurntSushi/ripgrep) as the grep program 
set grepprg=rg\ --vimgrep\ --no-column

function! s:GrepMotionedOverText(type)
    if a:type !=# "char"
        echoe "Cannot grep for lines or blocks"
    endif
    normal! `[v`]y
    silent exec "grep! " . @" | redraw!
    copen
endfunction

function! s:GrepVisuallySelectedText()
    normal! gvy
    silent exec "grep! " . @" | redraw!
    copen
endfunction

nnoremap <leader>g :set opfunc=<SID>GrepMotionedOverText<CR>g@
vnoremap <leader>g :call <SID>GrepVisuallySelectedText()<CR>
