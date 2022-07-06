" Description: Octave Configuration
" TODO: Should only execute this file when a .m file it's detected. 
" Not do it all with autocmd.

let g:loaded_matchit = 1
" activate matchit
set nocompatible
"runtime macros/matchit.vim
" enables search keyword in octave's documentation
autocmd FileType matlab setlocal keywordprg=konsole\ -e\ info\ octave\ --vi-keys\ --index-search"
" set matchit for octave sytanx
autocmd FileType matlab setlocal comments=s:%{,m:\ ,e:%},s:#{,m:\ ,e:#},:%,:#
autocmd FileType matlab setlocal commentstring=#\ %s
autocmd FileType matlab setlocal formatoptions-=t formatoptions+=croql
autocmd FileType matlab let s:conditionalEnd = '\(([^()]*\)\@!\<end\>\([^()]*)\)\@!'
autocmd FileType matlab let b:match_words = '\<if\>\|\<while\>\|\<for\>\|\<switch\>:' .
       \ s:conditionalEnd . ',\<if\>:\<elseif\>:\<else\>:' . s:conditionalEnd"

autocmd FileType matlab let b:match_words ..= ',' ..
                    \ '\<\%(classdef\|enumeration\|events\|for\|function\|if\|methods\|parfor\|properties\|switch\|while\|try\)\>' ..
                    \ ':' ..
                    \ '\<\%(elseif\|else\|case\|otherwise\|break\|continue\|catch\)\>' ..
                    \ ':' ..
                    \ '\<end\>'
" only match in statement position
autocmd FileType matlab let s:statement_start = escape('\%(\%(^\|;\)\s*\)\@<=', '\')
autocmd FileType matlab let b:match_words = substitute(b:match_words, '\\<', s:statement_start, 'g') 

" Matlab plugin
let g:matlab_auto_mappings = 0 "automatic mappings enabled
let g:matlab_server_launcher = 'vim'  "launch the server in a Neovim terminal buffer
let g:matlab_server_split = 'horizontal' "launch the server in a horizontal split
