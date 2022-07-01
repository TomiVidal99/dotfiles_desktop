" Description: Keymaps

" map leader
let mapleader = " " " map leader to Space

" copy from the cursor to the end of the line.
nnoremap Y y$

" alaways keep the cursor in the center when searching and using N and J to
" bind strings
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" only undo by break points, don't remove the entire line that you've written.
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u

" jumpt list mutations, basically add more points to jump when moving around.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" replace highlighted text with prompted input hotkey
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <S-r> :s//gc<left><left><left>

" move entire text up and down, by lines or by selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" when yanking directly copy all words
set clipboard+=unnamedplus

" Save file
map <C-s> :w <CR>

" Escape with Alt+a
imap <A-a> <Esc>

" Map ff (rapidly) to Enter
nmap ff <Return>

" Clear seach word with Alt+a
map <A-a> :noh<CR>

nnoremap <S-C-p> "0p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Delete a word backwards
"nnoremap dw vb"_d

" Select all
nmap <C-a> gg<S-v>G

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit 
nmap tt :tabnew 
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

"------------------------------
" Windows

" Split window
" move window to new tab
nmap st <C-w>T
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <a-l> <C-w><
nmap <a-h> <C-w>>
nmap <a-k> <C-w>+
nmap <a-j> <C-w>-

" Open the maps for all keys in the current filetype.
map <F2> <cmd> map <CR>

" Open a new terminal with the current path
map <F12> <cmd> exec '!konsole '.shellescape('%:p')' & disown' <CR>

" Terminals inside nvim.
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminalBottom()
  split term://zsh
  resize 10
endfunction
nnoremap <leader>tb <cmd> call OpenTerminalBottom() <CR>
nnoremap <leader>tr <cmd> vsplit term://zsh <CR>

" Quickfixlist
nmap <leader>qo <cmd>copen<cr>
nmap <leader>qc <cmd>cclose<cr>
nmap <leader>qn <cmd>cnext<cr>
nmap <leader>qp <cmd>cprev<cr>
nmap <leader>qh <cmd>chistory<cr>
