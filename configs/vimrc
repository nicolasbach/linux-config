set nocompatible                        " No compatibility with vi
set number                              " Show Line Numbers
set relativenumber                      " Show relative line numbers
set showmatch                           " Show matching brackets
set autoindent                          " indent a new line the same amount as the line just typed
set tabstop=4                           " number of columns occupied by a tab character
set expandtab                           " converts tabs to whitespace
set encoding=UTF-8                      " Set Encoding for vim-devicons
set scrolloff=999                       " Set cursor always in the center

syntax enable
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

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'          " Status bar at the bottom
Plug 'tpope/vim-surround'               " surround areas with stuff
Plug 'tpope/vim-fugitive'               " Git Plugin
Plug 'tpope/vim-commentary'             " Commenting out line
Plug 'preservim/nerdtree'               " File Browser
Plug 'jiangmiao/auto-pairs'             " Auto pair brackts
Plug 'sheerun/vim-polyglot'             " language pack
Plug 'ycm-core/YouCompleteMe'           " Auto completion
Plug 'Xuyuanp/nerdtree-git-plugin'      " NERDTree Git Status
Plug 'mhinz/vim-startify'               " Vim Startscreen
Plug 'ryanoasis/vim-devicons'           " Icons in NERDTree

call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure YouCompleteMe "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_auto_trigger = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Airline "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure NERDTree "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Focus window
autocmd VimEnter * NERDTree | wincmd p

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Keybindings "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :bo term<CR>
nnoremap <F4> :w<CR>
