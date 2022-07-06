if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> <leader>T <CMD>Telescope<CR>
nnoremap  <silent> <leader>g <CMD>lua require('telescope.builtin').live_grep()<CR>
nnoremap  <silent> <leader>s <CMD>lua require('telescope.builtin').grep_string()<CR>
nnoremap  <silent> <leader>f <CMD>lua require('telescope.builtin').find_files()<CR>
nnoremap  <silent> <leader>m <CMD>lua require('telescope.builtin').marks()<CR>
nnoremap  <silent> <leader>j <CMD>lua require('telescope.builtin').jumplist()<CR>
nnoremap  <silent> gr <CMD>lua require('telescope.builtin').lsp_references()<CR>
nnoremap  <silent> gd <CMD>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap  <silent> ga <CMD>lua require('telescope.builtin').lsp_code_actions()<CR>
nnoremap  <silent> gi <CMD>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap  <silent> ,c <CMD>lua require('telescope.builtin').git_commits()<CR>
nnoremap  <silent> ,l <CMD>lua require('telescope.builtin').git_bcommits()<CR>
nnoremap  <silent> ,b <CMD>lua require('telescope.builtin').git_branches()<CR>
nnoremap  <silent> ,s <CMD>lua require('telescope.builtin').git_status()<CR>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

function delete_all_marks() 
  -- deletes marks in the range p to z
	vim.api.nvim_command('delm! | delm A-Z0-9 | delm \"<>')
  print("Marks deleted! :)")
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["dam"] = delete_all_marks
      },
    },
  }
}
EOF
