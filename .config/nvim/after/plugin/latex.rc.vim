" shortcut to run the live preview with the compiler.
autocmd FileType tex map <F4> <cmd>LLPStartPreview <CR>

" default engine but the flag -shell-escape allows certain packages to compile.
let g:livepreview_engine = 'pdflatex' . ' -shell-escape'
