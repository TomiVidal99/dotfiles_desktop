-- Keymaps.

-- Modes:
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

-- Some helper variables
local get_os_keymaps = require("tomii.utils.get-os-keymaps")
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
kmn("<leader>k", "<CMD>Lspsaga hover_doc<CR>")
kmn("<leader>A", "<CMD>Lspsaga lsp_finder<CR>")

-- LATEX
kmn("<localleader>lc", "<CMD>VimtexCompile<CR>")
kmn("<localleader>li", "<CMD>VimtexInfo<CR>")

-- NERDTree (file explorer)
kmn("<C-b>", "<CMD>NERDTreeToggle | NERDTreeMirror<CR>")
kmn("<A-b>", "<CMD>NERDTreeFind<CR>")

---------- TELESCOPE ----------
-- Format code with LSP
kmn("<leader>F", "<CMD>lua vim.lsp.buf.format()<CR>")

-- All type of search: files, keywords, maps, etc.
kmn("gr", "<CMD>Telescope lsp_references<CR>")
kmn("gi", "<CMD>Telescope lsp_implementations<CR>")
kmn("gd", "<CMD>Telescope lsp_definitions<CR>")
kmn("<leader><leader>", "<CMD>Telescope find_files<CR>")
kmn("<leader>G", "<CMD>Telescope live_grep<CR>")
kmn("<leader>mm", "<CMD>Telescope marks<CR>")
kmn("<leader>jj", "<CMD>Telescope marks<CR>")
kmn("<leader>gC", "<CMD>Telescope git_commits<CR>")
kmn("<leader>gc", "<CMD>Telescope git_bcommits<CR>")
kmn("<leader>gb", "<CMD>Telescope git_branches<CR>")
kmn("<leader>gs", "<CMD>Telescope git_status<CR>")

---------- TERMINALS ----------
kmn("<leader>T", get_os_keymaps.get_new_tab_terminal()) -- starts a new terminal in a new tab
kmn("<leader>tr", get_os_keymaps.get_right_terminal()) -- starts a new terminal in the right side of the screen
kmn("<leader>tb", get_os_keymaps.get_bottom_terminal()) -- starts a new terminal in the bottom of the screen
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
--vim.cmd 'nnoremap <leader>d "_d' -- TODO: this does not work
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
kmn("t1", "<CMD>tabfirst<CR>") -- change to the first tab
kmn("t2", "<CMD>tabnext 2<CR>") -- change to the second tab
kmn("t3", "<CMD>tabnext 3<CR>") -- change to the third tab
kmn("t4", "<CMD>tabnext 4<CR>") -- change to the fourth tab
kmn("t5", "<CMD>tabnext 5<CR>") -- change to the 5th tab
kmn("t6", "<CMD>tabnext 6<CR>") -- change to the 6th tab
kmn("tt", "<CMD>tablast<CR>") -- change to the fourth tab

-- Edit tabs.
vim.cmd "nmap te :tabedit "

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

-- visual multi edit
vim.cmd [[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>' " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>' " replace visual C-n
]]

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
