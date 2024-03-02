call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'hashivim/vim-terraform'
call plug#end()

"================ Keybinds ================"
nmap <C-b> :Lexplore<CR>
nmap <C-p> :call FzfCommand()<CR>
nmap <C-f> :Rg<CR>
"=========================================="

"=============== Appearance ==============="
set number
set relativenumber
set ruler
set hlsearch

set t_ut=
set t_Co=256
set bg=dark

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

set termguicolors
"=========================================="

"============= Functionality =============="
" Tabs
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

" File syntax
filetype on
filetype plugin on
syntax on
"=========================================="


"================  Plugins ================"
" netrw
let g:netrw_winsize = 20
"=========================================="


"================ Functions ==============="
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
"=========================================="

" NOTES
if $NOTES != ""
  map <space>no $F(gf
  map <space>ni :edit $NOTES/README.md<CR>
  map <space>nn :NewNote<CR>
  map <space>nl :r!notes link<CR>

  command! -nargs=* NewNote call NewNote(<f-args>)

  func! NewNote()
		let book = input('Book> ')
		let title = input('Title> ')

		let note = system("notes new " . book . " '" . title . "'")
		exec "edit " . note
  endfunc
endif

let g:pandoc#syntax#conceal#urls = 1

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
