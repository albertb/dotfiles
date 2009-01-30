" .vimrc
set nowrap
set smartindent
set autoindent
set showtabline=2
set expandtab
set hidden
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set title
set scrolloff=3
set hlsearch
set incsearch
set shortmess=atl
set textwidth=0
set shiftwidth=2
set tabstop=2
set vb

syntax on
colorscheme inkpot

" Dvorak it!
no d h
no h j
no t k
no n l
no s :
no S :
no j d
no l n
no L N

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

function! HighlightTooLongLines()
  highlight def link RightMargin Error
  exec 'match RightMargin /\%<' . (84) . 'v.\%>' . (82) . 'v/'
endfunction

augroup filetypedetect
au BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/
