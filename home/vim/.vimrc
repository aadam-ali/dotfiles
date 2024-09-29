"""""""""""
" PLUGINS "
"""""""""""

call plug#begin()
Plug 'Aadam-Ali/sb.vim'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdtree'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()


""""""""""""""
" APPEARANCE "
""""""""""""""

colorscheme gruvbox-material
let g:gruvbox_material_background = "medium"
let g:gruvbox_material_enable_bold = 1

set t_ut=
set t_Co=256
set bg=dark

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 0

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = ''

set termguicolors

set number
set relativenumber


"""""""""""""
" BEHAVIOUR "
"""""""""""""

set hlsearch

set expandtab
set smarttab

set autoindent
set smartindent

set shiftwidth=2
set softtabstop=2
set tabstop=2

set textwidth=72
set formatoptions-=t

set backspace=indent,eol,start

filetype on
filetype plugin on
syntax on

" Netrw
let g:netrw_winsize = 20

" Pandoc
let g:pandoc#syntax#conceal#urls = 1

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" Enable Transparency
" hi Normal guibg=NONE ctermbg=NONE


""""""""""""
" KEYBINDS "
""""""""""""

nmap <C-b> :NERDTreeToggle<CR>
nmap <C-p> :call FzfCommand()<CR>
nmap <C-f> :Rg<CR>


""""""""""""
" FUNCTION "
""""""""""""

function! FzfCommand()
  let output = system("git rev-parse")
  if v:shell_error == 0
    let command = ':GFiles'
  else
    let command = ':Files'
  endif
  redraw!
  exec command
endfunction


""""""""""""""""
" SECOND BRAIN "
""""""""""""""""
map <space>si :edit $SB<CR>
map <space>sl :SBLinkNote<CR>
map <space>sn :SBNewNote<CR>
map <space>so :SBOpenNote<CR>
map <space>sp :SBNewPrivateNote<CR>
