if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}
saga.setup {
  finder_action_keys = {
    scroll_down = "<C-p>",
    scroll_up = "<C-n>",
  }
}

local map = vim.api.nvim_buf_set_keymap
map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

EOF

"nnoremap <silent> <C-k> <cmd>Lspsaga code_action<CR>
"nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>
"nnoremap <silent> gp <cmd>Lspsaga preview_definition<CR>
