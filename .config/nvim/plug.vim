if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has("nvim")

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }
  Plug 'folke/lsp-colors.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'williamboman/nvim-lsp-installer'

  " UI
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kyazdani42/nvim-web-devicons'

  " snippets
  Plug 'L3MON4D3/LuaSnip'

  " comments
  Plug 'numToStr/Comment.nvim'

  " completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'

  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'andymass/vim-matchup'

  " Highlight and indentation
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'p00f/nvim-ts-rainbow'

  " File management
  Plug 'preservim/nerdtree'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " octave/matlab
  "Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
  Plug 'mstanciu552/cmp-matlab'
  Plug 'mstanciu552/cmp-octave'

  " c and cpp
  Plug 'p00f/clangd_extensions.nvim'

  " latex
  Plug 'lervag/vimtex'

  " Debugger
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'nvim-telescope/telescope-dap.nvim'

endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
