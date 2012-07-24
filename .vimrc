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

" w!! sudo saves
cmap w!! %!sudo tee > /dev/null %

"switch between .h / -inl.h / .cc / .py / .js / _test.* / _unittest.* with ,h ,i ,c ,p ,j ,t ,u
"(portion from old mail from David Reiss)
let pattern = '\(\(_\(unit\)\?test\)\?\.\(cc\|js\|py\)\|\(-inl\)\?\.h\)$'
nmap ,c :e <C-R>=substitute(expand("%"), pattern, ".cc", "")<CR><CR>
nmap ,h :e <C-R>=substitute(expand("%"), pattern, ".h", "")<CR><CR>
nmap ,i :e <C-R>=substitute(expand("%"), pattern, "-inl.h", "")<CR><CR>
nmap ,t :e <C-R>=substitute(expand("%"), pattern, "_test.", "") . substitute(expand("%:e"), "h", "cc", "")<CR><CR>
nmap ,u :e <C-R>=substitute(expand("%"), pattern, "_unittest.", "") . substitute(expand("%:e"), "h", "cc", "")<CR><CR>
nmap ,p :e <C-R>=substitute(expand("%"), pattern, ".py", "")<CR><CR>
nmap ,j :e <C-R>=substitute(expand("%"), pattern, ".js", "")<CR><CR>

" , #perl # comments
map ,# :s/^/#/<CR>
" ,/ C/C++/C#/Java // comments
map ,/ :s/^/\/\//<CR>
" ,< HTML comment
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>
" c++ java style comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

" Customize qnamefile
nmap ,F :call QNameFileInit("", "", 0)<cr>:~
nmap ,f :call QNameBufInit(1)<cr>:~

if filereadable(expand("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
