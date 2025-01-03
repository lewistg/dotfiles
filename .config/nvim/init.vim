set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Wait for <CR> before jumping to results
set noincsearch
" Turn off search highlighting
set nohlsearch

" Use traditional j/k movement keys to navigate the popup menu
inoremap <expr> <c-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" Use j/k to cycle through wildmenu
cnoremap <c-k> <Left>
cnoremap <c-j> <Right>

" Disable mouse right-click menu (:help default-mouse)
set mouse=

" Use + register, the register tied to the sytem clipboard, as the unnamed
" register. In other words, yanks and pastes will come from the system
" clipboard.
set clipboard=unnamedplus

" Quickly edit Neovim config
nnoremap <Leader>evc :e ~/.config/nvim/init.vim<CR>

" Source plugin config (if any)
runtime init-plugins.vim
runtime init-plugins.lua
