call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

"================ Keybinds ================"
nmap <C-b> :Lexplore<CR>
nmap <C-p> :call FzfCommand()<CR>
nmap <C-f> :Rg<CR>
"=========================================="

"=============== Appearance ==============="
set number
set ruler
set hlsearch

set t_ut=
set t_Co=256
set bg=dark

colorscheme codedark

if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif
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
  map <space>nn :NewNote
  map <space>nl :r!notes link<CR>

  command! -nargs=* NewNote call NewNote(<f-args>)

  func! NewNote(book, ...)
    let l:dname = expand('$NOTES/') . a:book
    call mkdir(l:dname, "p")

    let l:fname = l:dname . '/' . strftime("%Y%m%d%H%M%S") . '.md'
    call writefile(["# " . join(a:000, " ")], l:fname)

    exec "edit " . l:fname
  endfunc
endif
