"================ Keybinds ================"
nmap <C-l> :r!nb link<CR>
nmap <C-b> :Lexplore<CR>
nmap <C-p> :call FzyCommand("find * -type f 2>&1", "git ls-files -co --exclude-standard", ":e")<cr>
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

" vim-python
let g:python_highlight_all = 1
"=========================================="


"================ Functions ==============="
function! FzyCommand(choice_command, git_choice_command, vim_command)
  try
    let output = system("git rev-parse")
    if v:shell_error == 0
      let output = system(a:git_choice_command . " | fzy ")
    else
      let output = system(a:choice_command . " | grep -Ev 'venv|.git' | fzy ")
    endif
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction
"=========================================="
