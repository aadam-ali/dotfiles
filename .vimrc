""" Keybinds
nmap <C-l> :r!nb link<CR>
nmap <C-b> :Lexplore<CR>


""" Appearance
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


""" Functionality
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


""" Plugins
" netrw
let g:netrw_winsize = 20

" vim-python
let g:python_highlight_all = 1
