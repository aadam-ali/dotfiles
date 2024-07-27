"""""""""""
" PLUGINS "
"""""""""""

call plug#begin()
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
let g:gruvbox_material_background = "hard"
let g:gruvbox_material_enable_bold = 1

set t_ut=
set t_Co=256
set bg=dark

let g:airline_symbols = {}
let g:airline_symbols.colnr = ' '

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
hi Normal guibg=NONE ctermbg=NONE

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

if $SB != ""
  map <space>no :OpenNote<CR>
  map <space>ni :edit $NOTES/README.md<CR>
  map <space>nn :NewNote<CR>
  map <space>nl :r!sb link<CR>

  command! -nargs=* NewNote call NewNote(<f-args>)
  command! -nargs=* OpenNote call OpenNote(<f-args>)

  func! NewNote()
		let title = input('Title> ')

		let note = system("sb new '" . title . "'")
		exec "edit " . note
  endfunc

  func! OpenNote()
    let line=getline('.')
    let path = system("sb path " . "'" . line . "'")
    exec "edit " . path
  endfunc
endif
