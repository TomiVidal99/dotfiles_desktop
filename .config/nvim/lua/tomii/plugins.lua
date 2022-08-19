-- Loads plugins.
-- I use packer, more info: https://github.com/wbthomason/packer.nvim

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  }
}

-- Install and configurate plugins
return packer.startup(function(use)

  -- BASE PLUGINS
  use "wbthomason/packer.nvim" -- The packer manager itself
  use "nvim-lua/popup.nvim" --An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua function used in lots of plugins

  -- THEME
  use {
    "svrana/neosolarized.nvim", -- actual theme
    requires = { "tjdevries/colorbuddy.nvim" }
  }
  use "lukas-reineke/indent-blankline.nvim" -- identation lines
  use {
    "nvim-lualine/lualine.nvim", -- status line down below
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }

  -- LSP
  use { -- general config for the LSP
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  }
  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    run = function() 
      require("lspsaga").init_lsp_saga()
    end
  } -- better UI for LSP related
  use { -- Type checking
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "nvim-treesitter/playground"

  -- COMPLETION
  use { "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline" }
  }
  use "hrsh7th/cmp-nvim-lua" -- completion for lua inside nvim

  -- SPELL CHECKING
  use "f3fora/cmp-spell"
  -- use "uga-rosa/cmp-dictionary" -- dictionary

  -- SNIPPETS
  use { "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } } -- snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Navigation
  use { "nvim-telescope/telescope.nvim", tag = "0.1.0" } -- general navigation
  use "preservim/nerdtree" -- file explorer

  -- Latex
  use "lervag/vimtex"
  use {
    "kdheepak/cmp-latex-symbols",
    requires = {
      { "hrsh7th/nvim-cmp" },
    },
  }

  -- UTILS: utility plugins to make my life easier :)
  use "norcalli/nvim-colorizer.lua" -- Color display (shows the color when the text it's #ff0000 and so on)
  use { -- closing ts tags automatically
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end
  }
  use { -- visual indicator for git repositories
    "tanvirtin/vgit.nvim",
    requires = {
      { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" }
    }
  }
  use { -- brackets and parenthesis and so on indicators
    "p00f/nvim-ts-rainbow",
    requires = {
      { "nvim-treesitter/nvim-treesitter" }
    }
  }

  -- REACT, TSX, ETC
  use {  -- tailwind completion
    'mrshmllow/document-color.nvim',
    config = function()
      require("document-color").setup {
      -- Default options
      mode = "background", -- "background" | "foreground" | "single"
  }
  end
}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)