let mapleader=" "
set encoding=utf-8
set number relativenumber
set cursorline
set termguicolors
noremap <LEADER><CR> :nohlsearch<CR>

" auto download vim-plug in a fresh machine
if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p $HOME/.config/nvim/autoload/
  silent !mkdir -p $HOME/.config/nvim-plugin
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

" vim-plug
call plug#begin('~/.config/nvim-plugin')
Plug 'vim-airline/vim-airline'
call plug#end()

