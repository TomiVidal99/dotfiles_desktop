" shortcut to run the live preview with the compiler.
autocmd FileType tex map <F5> <cmd> LLPStartPreview <CR>

" Default previewer
let g:livepreview_previewer = 'okular'

" default engine but the flag -shell-escape allows certain packages to compile.
let g:livepreview_engine = 'pdflatex' . ' -shell-escape'

