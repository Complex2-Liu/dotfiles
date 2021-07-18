let mapleader=" "
set encoding=utf-8
set number relativenumber
set cursorline
set termguicolors
noremap <LEADER><CR> :nohlsearch<CR>

" vim-plug
call plug#begin('~/.config/nvim-plugin')
Plug 'vim-airline/vim-airline'
call plug#end()

