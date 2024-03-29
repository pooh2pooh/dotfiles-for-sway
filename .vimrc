"return" 2>&- || "exit"

set nocompatible              " be iMproved, required
filetype plugin on            " required
filetype indent on
syntax on
colorscheme solarized8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set mouse=a
set nu
set encoding=utf-8
"set cursorline
set autoindent
set tabstop=4 softtabstop=4 shiftwidth=4
set noswapfile
set incsearch
set title
set bg=dark

hi Normal ctermbg=NONE
"hi CursorLine term=bold cterm=bold ctermbg=16
"hi CursorLineNr term=bold cterm=bold ctermfg=106

let g:file_template_default = {}
let g:file_template_default['html'] = 'skeleton'

let g:airline_theme='solarized_flood'

noremap <F3> :Autoformat<CR>

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-autoformat/vim-autoformat'
Plugin 'tribela/vim-transparent'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" When editing a file, always jump to the last known cursor position.
" " Don't do it when the position is invalid or when inside an event handler
" " (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Add Highlight syntax for systemd services
autocmd BufNewFile,BufRead *.service* set ft=systemd
