" vim: set expandtab ts=2 sw=0 :

set nocompatible
if has("win32")
  set packpath^=$HOME/.vim
  set viminfofile=$HOME/.viminfo
  set shell=zsh.exe
endif

function! s:is_plugin_installed(plugin_name)
  return isdirectory(expand("~/.vim/pack/default/start/" . a:plugin_name))
endfunction
let s:plugin_installed__CandyPaper = s:is_plugin_installed("CandyPaper.vim")
let s:plugin_installed__nerdtree = s:is_plugin_installed("nerdtree")

syntax on
if has("termguicolors")
  set termguicolors
endif

if has("gui_running")
  if s:plugin_installed__CandyPaper
    colorscheme CandyPaper
  endif
  set columns=125 lines=50
  set guioptions=
  set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
  if has("win32")
    set guifont=Fira\ Code\ Retina:h10
  else
    set guifont=Fira\ Code\ weight=450\ 10
  endif
else
  if $TERM !=# "linux" && s:plugin_installed__CandyPaper
    colorscheme CandyPaper
  endif
endif


set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,japan,latin1
set fileformat=unix
set fileformats=unix,dos

filetype plugin indent on
set cindent
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=0

set hlsearch
set incsearch

set foldmethod=syntax
set foldlevelstart=99

set showtabline=2
set number
set signcolumn=number
set cursorline
set display=lastline
set laststatus=2
set wildmenu
set shortmess=filnxtToOF
set showcmd
set showmatch
function! s:status_line__character_index()
  let column = getcurpos()[2]
  return strchars(strpart(getline("."), 0, column - 1)) + 1
endfunction
let s:status_line__editor_mode_mapping = {
      \ "n": "NORMAL",
      \ "v": "VISUAL",
      \ "V": "V-LINE",
      \ "^V": "V-BLOCK",
      \ "s": "SELECT",
      \ "S": "S-LINE",
      \ "^S": "S-BLOCK",
      \ "i": "INSERT",
      \ "R": "REPLACE",
      \ "c": "COMMAND",
      \ }
function! s:status_line__editor_mode()
  return s:status_line__editor_mode_mapping->get(mode(), "OTHERS")
endfunction
function! s:status_line()
  let result = " %F %h%r%m" " full file path / help marker / read-only marker / modified marker
  let result .= "%="
  let result .= "[%l:%{" .. expand("<SID>") .. "status_line__character_index()}][%4.P]  " " cursor position
  let result .= "%y[%{&fenc}/%{&ff}]" " file type / encoding / eol
  let result .= "%10.([%{" .. expand("<SID>") .. "status_line__editor_mode()}]%) "
  return result
endfunction
let &statusline = "%!" .. expand("<SID>") .. "status_line()"

set autochdir
set autoread
set belloff=all
set clipboard^=unnamed,unnamedplus
set ttimeout
set ttimeoutlen=50
set nobackup
set nojoinspaces
set noswapfile
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

let g:is_bash = 1

set backspace=indent,eol,start
set winaltkeys=no
let g:mapleader = " "
vnoremap p "_dgP
vnoremap P "_dgP
nnoremap Y y$
if s:plugin_installed__nerdtree
  nnoremap <silent> <F3> :NERDTreeToggle<CR>
endif
nnoremap <F4> :tabnew<CR>
nnoremap <F12> :terminal<CR>
nnoremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>
vnoremap <C-C> y
nnoremap <C-V> gP
vnoremap <C-V> "_dgP
inoremap <C-V> <C-R><C-R>+
nnoremap <M-j> gj
nnoremap <M-k> gk
vnoremap <M-j> gj
vnoremap <M-k> gk
inoremap <M-j> <C-O>gj
inoremap <M-k> <C-O>gk

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
