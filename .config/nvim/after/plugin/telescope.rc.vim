if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap  <silent> <leader>s <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap  <silent> <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap  <silent> <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap  <silent> <leader>q <cmd>lua require('telescope.builtin').quickfixlist()<cr>
nnoremap  <silent> <leader>j <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap  <silent> gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap  <silent> gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap  <silent> ga <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap  <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap  <silent> ,c <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap  <silent> ,l <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap  <silent> ,b <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap  <silent> ,s <cmd>lua require('telescope.builtin').git_status()<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

function delete_all_marks() 
  -- deletes marks in the range p to z
	--return lua delm! | delm A-Z0-9     
	--delm! | delm A-Z0-9     
  --print("Marks deleted! :)")
  print("TODO :)")
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
