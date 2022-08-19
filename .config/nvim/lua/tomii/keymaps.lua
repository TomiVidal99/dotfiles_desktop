-- Keymaps.

-- Modes:
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

-- Some helper variables
local opts = { noremap = true, silent = true }
local km = vim.keymap.set

-- Helper function to set a normal keymap.
local kmn = function(key, func)
  km("n", key, func, opts)
end
--local kmi = function(key, func)
--  km("i", key, func, opts)
--end
local kmv = function(key, func)
  km("v", key, func, opts)
end
local kmb = function(key, func)
  km("x", key, func, opts)
end

-- Remap leader to space.
km("", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

---------- NORMAL ----------
-- Lspsaga 
kmn("<leader>ca", "<CMD>Lspsaga code_action<CR>")

-- LATEX
kmn("<localleader>lc", "<CMD>VimtexCompile<CR>")
kmn("<localleader>li", "<CMD>VimtexInfo<CR>")

-- NERDTree (file explorer)
kmn("<C-b>", "<CMD>NERDTreeToggle | NERDTreeMirror<CR>")
kmn("<A-b>", "<CMD>NERDTreeFind<CR>")

---------- TELESCOPE ----------
-- All type of search: files, keywords, maps, etc.
kmn("<leader><leader>", "<CMD>Telescope find_files<CR>")
kmn("<leader>G", "<CMD>Telescope live_grep<CR>")

---------- TERMINALS ----------
kmn("<leader>T", "<CMD>tabedit term://zsh | tabmove 0<CR>") -- starts a new terminal in a new tab
kmn("<leader>tr", "<CMD>vsplit term://zsh<CR>") -- starts a new terminal in the right side of the screen
kmn("<leader>tb", "<CMD>split term://zsh | resize 10<CR>") -- starts a new terminal in the bottom of the screen
vim.cmd "au BufEnter * if &buftype == 'terminal' | :startinsert | endif" -- start terminal in insert mode
vim.cmd "tnoremap <A-a> <C-\\><C-n>" -- this lets you scape the terminal and switch windows and/or tabs
kmn("<F12>", "<CMD>exec '!konsole '.shellescape('%:p')' & disown'<CR>") -- launches a new window in the current path

-- Change spell check
kmn("<F10>", "<CMD>set spell!<CR>")

-- DIAGNOSTICS MAPS
kmn("<leader>D", "<CMD>Telescope diagnostics<CR>")
kmn("<C-n>", vim.diagnostic.goto_next)
kmn("<C-p>", vim.diagnostic.goto_prev)

-- Save with root permission.
vim.cmd "command! W w !sudo tee > /dev/null %"

-- Delete without yank.
vim.cmd 'nnoremap <leader>d "_d'
vim.cmd 'nnoremap x "_x'

-- Increment/decrement.
vim.cmd "nnoremap + <C-a>"
vim.cmd "nnoremap - <C-x>"

-- Remap enter to ff (rapidly)
vim.cmd "nmap ff <return>"

-- Save file.
kmn("<C-s>", "<CMD>w<CR>")

-- Quickfixlist.
kmn("<leader>qo", "<CMD>copen<CR>")
kmn("<leader>qc", "<CMD>cclose<CR>")
kmn("<leader>qn", "<CMD>cnext<CR>")
kmn("<leader>qp", "<CMD>cprev<CR>")
kmn("<leader>qh", "<CMD>chistory<CR>")

-- Better window navigation.
kmn("<C-h>", "<C-w>h")
kmn("<C-j>", "<C-w>j")
kmn("<C-k>", "<C-w>k")
kmn("<C-l>", "<C-w>l")

-- Resize with alt+(h,j,k,l).
kmn("<a-k>", "<CMD>resize -2<CR>")
kmn("<a-j>", "<CMD>resize +2<CR>")
kmn("<a-h>", "<CMD>vertical resize -2<CR>")
kmn("<a-l>", "<CMD>vertical resize +2<CR>")

-- Move between windows with s+(h,j,k,l)
kmn("sh", "<CMD>wincmd h<CR>")
kmn("sj", "<CMD>wincmd j<CR>")
kmn("sk", "<CMD>wincmd k<CR>")
kmn("sl", "<CMD>wincmd l<CR>")

-- Move and split windows
kmn("st", "<CMD>wincmd t<CR>")
kmn("ss", "<CMD>wincmd s<CR>")
kmn("sv", "<CMD>wincmd v<CR>")

-- Navigate tabs.
kmn("<C-l>", "<CMD>tabnext<CR>")
kmn("<C-h>", "<CMD>tabprevious<CR>")
kmn("Th", "<CMD>-tabmove<CR>") -- move the current window to the next left tab
kmn("Tl", "<CMD>+tabmove<CR>") -- move the current window to the next left tab
kmn("T0", "<CMD>tabmove 0<CR>") -- move the current window to the beginning tab
kmn("T$", "<CMD>tabmove<CR>") -- move the current window to the end tab

-- Edit tabs.
vim.cmd "nmap te :tabedit "
kmn("tt", "<CMD>tabnew<CR>")

-- Remove highlight
vim.cmd "map <A-a> <CMD>noh<CR>"

---------- INSERT ----------
-- Quit insert.
vim.cmd "imap <A-a> <Esc>"

---------- VISUAL ----------
-- Paste and don't yank.
kmv("p", '"_dP')

-- Quit visual mode with Alt+a.
vim.cmd "vmap <A-a> <Esc>"

-- Stay in indent mode.
kmv("<", "<gv")
kmv(">", ">gv")

-- Move entire selected lines up and down.
vim.cmd "vnoremap K :m '<-2<CR>gv=gv"
vim.cmd "vnoremap J :m '>+1<CR>gv=gv"

---------- VISUAL BLOCK ----------
kmb("J", ":m '>+1<CR>gv-gv")
kmb("K", ":m '<-2<CR>gv-gv")
kmb("<A-j>", ":m '>+1<CR>gv-gv")
kmb("<A-k>", ":m '<-2<CR>gv-gv")
