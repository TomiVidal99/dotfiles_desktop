if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

" Update plugins if this file changes.
autocmd BufWritePost plugs.vim source <afile> | PlugInstall

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

  " UI, TODO: check this plugs and change them accordingly.
  Plug 'hoob3rt/lualine.nvim'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
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
  Plug 'mfussenegger/nvim-dap-python'
  Plug 'theHamsta/nvim-dap-virtual-text'

  " Grammar check
  Plug 'rhysd/vim-grammarous'

  " Colors display (RGB, HEX, HSL) and modifier
  Plug 'ziontee113/color-picker.nvim'

  " Utility Functions as dependencies for other packages
  Plug 'nvim-lua/plenary.nvim'

  " Git status on files 
  Plug 'tanvirtin/vgit.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
