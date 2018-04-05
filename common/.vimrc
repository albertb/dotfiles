" .vimrc

call pathogen#infect()

set autoindent
set cul
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noswapfile
set nowrap
set nu
set scrolloff=3
set shiftwidth=2
set showtabline=2
set shortmess=atl
set smartcase
set smartindent
set tabstop=2
set textwidth=0
set title
set visualbell
set wildmenu
set wildmode=list:longest

set statusline=%<[%02n]\ %F%(\ %m%h%w%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%03b]

runtime macros/matchit.vim

syntax on
colorscheme desert

" Dvorak it!
no s :
no S :

imap hh <esc>
map <c-s> :bn<enter>
map <c-n> :bp<enter>
map <c-e> :cnext<enter>
map <c-o> :cprev<enter>

" w!! sudo saves
cmap w!! %!sudo tee > /dev/null %

let mapleader = ","

" Customize qnamebuf
nmap <leader>f :call QNameBufInit(1)<cr>:~

" Customize CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = 'cd %s && hg files'
let g:ctrlp_map = ',F'

if filereadable(expand("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
