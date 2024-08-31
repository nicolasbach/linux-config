set nocompatible
set number                              " Show Line Numbers
set relativenumber                      " Show relative line numbers
set showmatch                           " Show matching brackets
set autoindent                          " indent a new line the same amount as the line just typed
set tabstop=4                           " number of columns occupied by a tab character
set expandtab                           " converts tabs to whitespace

syntax on
filetype on
filetype plugin on
filetype indent on

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

call plug#end()


map <F2> :NERDTreeToggle<CR>
