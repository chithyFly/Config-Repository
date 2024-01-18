set relativenumber
set number

syntax on

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

set smartindent

set hidden

" Enable search as typing, instead of after press 'enter'
set incsearch
" Enable hightlight match search content
set hlsearch
" Cancel highlight search after press `<enter>`(same with <ctrl-[>)
nnoremap <esc> :noh<return><esc>

set mouse+=a

set ignorecase
set smartcase

" Expand the command history record to 200
set history=200

" Command line auto-completion with bash shell habits
set wildmode=longest,list

" Autocomplete {}
inoremap { {<CR>}<ESC>kA

" Map %% -> %:h<Tab>, Explain: type %% expand automatically path for active buffer in command line mode
" Note:':h' delete the file name 
"      '%'  expand the path relative to the current working dictory
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'
