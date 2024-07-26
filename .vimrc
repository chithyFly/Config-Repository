set nocompatible

" Let netrw don't save history or bookmarks:
:let g:netrw_dirhistmax = 0

syntax on

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smartindent

set hidden

set nowrap

" Enable search as typing, instead of after press 'enter'
set incsearch

set mouse+=a

set ignorecase
set smartcase

" Expand the command history record to 200
set history=200

" Command line auto-completion with bash shell habits
set wildmode=longest,list

" This will look in the current directory for "tags", and work up the tree towards root until one is found.
set tags=./tags;/
