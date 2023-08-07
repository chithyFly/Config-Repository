set relativenumber
set number

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


set smartindent
set hidden

"Expand the command history record to 200(default 20)
set history=200

"Command line auto-completion with bash shell habits
set wildmode=longest,list

" Highlight the matching texts when searching
set hlsearch

" Press <esc> to cancel the search highlighting
nnoremap <esc> :noh<return><esc>

" Press <ctrl + [> to cancel the search highlighting
inoremap <C-[> <Esc>:nohlsearch<CR>

" Highlight the current matching text automatically
set incsearch

set mouse=a

" Autocomplete {}
inoremap { {<CR>}<ESC>kA

" Vim script: A search is performed on the selected content only int he visual mode; '*', next; '#', last.
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
