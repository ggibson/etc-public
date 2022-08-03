set tabstop=4
set expandtab
set shiftwidth=4
set number

colorscheme industry
"so ~/tmp/vim-themes/simple-dark.vim

" h8 the bright line numbering
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

highlight Folded ctermbg=black ctermfg=DarkGrey

set path=.,,**

let mapleader = " "

map <Tab> :bn<cr>
map <S-Tab> :bp<cr>

map <Leader><Tab> :tabnext<cr>

nmap <C-p> :find 

" wildcard ignore
set wildignore+=*.swp,*.egg-info*,*.egg-link,*.pyc,*.pyo,*/eggs/*

" enable wildcard menu; e.g. when doing :vs **/*<thing to search for>
set wildmenu

" default netrw view to list 
let g:netrw_liststyle= 3
let g:netrw_altv=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" depends on exteral programs, but these are *very* useful
set makeprg=pylint\ %
set grepprg=ag


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags stuff
set tags+=tags;/
