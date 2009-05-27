" .vimrc

source /home/build/public/eng/vim/google.vim

set autoindent
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nowrap
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

set statusline=%<[%02n]\ %F%(\ %m%h%w%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%02B]

runtime macros/matchit.vim

syntax on
colorscheme desert

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

" F2 formats to 80 cols
map #2 !fmt -80

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

" perforce commands
command! -nargs=* -complete=file PEdit :!g4 edit %
command! -nargs=* -complete=file PRevert :!g4 revert %
command! -nargs=* -complete=file PDiff :!g4 diff %

function! s:CheckOutFile()
 if filereadable(expand("%")) && ! filewritable(expand("%"))
   let option = confirm("Readonly file, do you want to checkout from p4?"
         \, "&Yes\n&No", 1, "Question")
   if option == 1
     PEdit
   endif
   edit!
 endif
endfunction
au FileChangedRO * nested :call <SID>CheckOutFile()

function! EnterPerforceFile()
  setlocal nolist noet tw=0 ts=8 sw=8 sts=8 ft=conf
  if search("<enter description here>") > 0
    normal C
    startins!
  elseif bufname('*') != 'message'
    /^Description:/
    normal 2w
  endif
endfunction

augroup filetypedetect
au BufNewFile,BufRead /tmp/g4_*,*p4-change*,*p4-client* call EnterPerforceFile()
augroup END

function! HighlightTooLongLines()
  highlight def link RightMargin Error
  exec 'match RightMargin /\%<' . (81) . 'v.\%>' . (83) . 'v/'
endfunction

augroup filetypedetect
au BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/
