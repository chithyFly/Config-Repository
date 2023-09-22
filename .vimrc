set relativenumber
set number

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


set smartindent
set hidden
set mouse=a

" Highlight the matching texts when searching
set hlsearch

" Highlight the current matching text automatically
set incsearch

"Expand the command history record to 200
set history=200

"Command line auto-completion with bash shell habits
set wildmode=longest,list

" Autocomplete {}
inoremap { {<CR>}<ESC>kA

" Press <esc> to cancel the search highlighting
nnoremap <esc> :noh<return><esc>

" Map %% -> %:h<Tab>, Explain: type %% expand automatically path for active buffer in command line mode
" Note -> ':h' delete the file name 
"         '%'  expand the path relative to the current working dictory
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'
