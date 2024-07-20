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

" Quickly edit Neovim config
nnoremap <Leader>evc :e ~/.config/nvim/init.vim<CR>

" Load plugin config
let s:plugin_config = "~/.config/nvim/init-plugins.vim"
if filereadable(expand(s:plugin_config))
    exec "source " . s:plugin_config
endif
