"return" 2>&- || "exit"

set nocompatible              " be iMproved, required
syntax on
colorscheme solarized8

" Enable filetype detection, and load filetype-specific plugins and
" indentation.
filetype plugin indent on

" Enable visual autocomplete of commands.
set wildmenu

" Enable the ruler that shows the cursor position.
set ruler

" Automatically reload files if they changed outside of Vim, do not ask.
set autoread

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set mouse=a
set nu

" Use UTF-8 as encoding.
set encoding=utf-8
set fileencoding=utf-8

" set cursorline

" Indent by two spaces please.
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Enable auto-indent (copies the indent of the current line when starting a
" new line). Do *not* enable smart indent, it breaks stuff for many languages
" (including comments in Python), and the filetype specific plugins should
" have a better indentation scheme anyway.
set autoindent
set nosmartindent

" Do not insert a line break when I type past the text width.
set formatoptions-=t

" Highlight the column after the text width.
set colorcolumn=+1

" Default to 80 columns. Can be overridden by the file type later.
set textwidth=80

set noswapfile

" Highlight search results, do incremental search.
" set hlsearch -- or not, looks ugly
set incsearch

" Highlight matching brackets for 0.2 seconds.
set showmatch
set matchtime=2

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
Plugin 'dense-analysis/ale'
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
