" Config for the plugs (debugger): 
" - 'mfussenegger/nvim-dap'
" - 'rcarriga/nvim-dap-ui'
" - 'nvim-telescope/telescope-dap.nvim'

" KEYMAPS
nmap <F5> <CMD> lua require("dapui").toggle() <CR>
nmap <F9> <CMD> lua require("dap").continue() <CR>
"nmap <F10> <CMD> lua require("dap").step_over() <CR>
"nmap <F11> <CMD> lua require("dap").step_into() <CR>
"nmap <F12> <CMD> lua require("dap").step_out() <CR>
nmap <F10> <CMD> lua require("dap").down() <CR>
nmap <F12> <CMD> lua require("dap").up() <CR>
nmap <leader>B <CMD> lua require("dap").toggle_breakpoint() <CR>
