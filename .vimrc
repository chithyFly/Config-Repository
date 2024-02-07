set relativenumber
set number

" Let netrw will save no history or bookmarks:
:let g:netrw_dirhistmax = 0

syntax on

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smartindent

set hidden

" Enable search as typing, instead of after press 'enter'
set incsearch
" Enable hightlight match search content
set hlsearch

set mouse+=a

set ignorecase
set smartcase

" Expand the command history record to 200
set history=200

" Command line auto-completion with bash shell habits
set wildmode=longest,list

" Autocomplete {}
inoremap { {<CR>}<ESC>kA

" <C-l> used to be cleaing and redrawing display screen
" The new mapping <C-l> increase temporary diable hightlight search functionality
nnoremap<silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" <ctrl-b> open NERDTreeToggle
nnoremap <C-b> :NERDTreeToggle<CR>

" Visual mode search select text(vim built-in, `:h visual-search` to help
" Note: . and * character sometimes cause problem
:vmap X y/<C-R>"<CR>

" Map %% -> %:h<Tab>, Explain: type %% expand automatically path for active buffer in command line mode
" Note:':h' delete the file name 
"      '%'  expand the path relative to the current working dictory
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

" Vim plug config
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
