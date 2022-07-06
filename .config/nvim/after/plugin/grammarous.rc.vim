" PLUG: rhysd/vim-grammarous
" For checking grammar.
" vim-grammarous is a powerful grammar checker for Vim. Simply do :GrammarousCheck to see the powerful checking. 
" This plugin automatically downloads LanguageTool, which requires Java 8+.

" For example, below setting makes grammar checker check comments only except for markdown and vim help.
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
