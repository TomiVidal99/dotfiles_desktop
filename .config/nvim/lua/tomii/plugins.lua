-- Loads plugins.
-- I use packer, more info: https://github.com/wbthomason/packer.nvim

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install and configurate plugins
return packer.startup(function(use)
	-- BASE PLUGINS
	use("wbthomason/packer.nvim") -- The packer manager itself
	use("nvim-lua/popup.nvim") --An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua function used in lots of plugins

	-- THEME
	use({
		"svrana/neosolarized.nvim", -- actual theme
		requires = { "tjdevries/colorbuddy.nvim" },
	})
	use("lukas-reineke/indent-blankline.nvim") -- identation lines
	use({
		"nvim-lualine/lualine.nvim", -- status line down below
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})
	use("fgheng/winbar.nvim") -- winbar
	use({ -- tab theme
		"kdheepak/tabline.nvim",
		requires = {
			{ "hoob3rt/lualine.nvim" },
			{ "nvim-lua/lsp-status.nvim" },
		},
	})

	-- LSP
	use({ -- general config for the LSP
		"williamboman/nvim-lsp-installer",
		"neovim/nvim-lspconfig",
	})
	use({ -- LSP loading display
		"j-hui/fidget.nvim",
	})
	use({ -- better UI for LSP related
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use({ -- icons
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({})
		end,
	})
	use({ -- Type checking
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground") -- adds type checking and other things to treesitter
	use("jose-elias-alvarez/null-ls.nvim") -- more lsp stuff: completion, formatting and so one, that some lsp dont come with
	use({ -- lets you manage external tools like LSPs, DAP servers, etc. without the need of you having to install the binaries independenlty.
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})

	-- COMPLETION
	use({
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline" },
	})
	use("hrsh7th/cmp-nvim-lua") -- completion for lua inside nvim

	-- SPELL CHECKING
	use("f3fora/cmp-spell")
	-- use "uga-rosa/cmp-dictionary" -- dictionary

	-- SNIPPETS
	use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } }) -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Navigation
	use({ -- general navigation
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		config = function()
			require("telescope").setup({ defaults = { file_ignore_patterns = { "node_modules", ".git" } } })
		end,
	})
	use("preservim/nerdtree") -- file explorer
	use({ "Xuyuanp/nerdtree-git-plugin", requires = { { "preservim/nerdtree" } } }) -- displays git status on nerdtree
	use({ "ryanoasis/vim-devicons", requires = { { "preservim/nerdtree" } } }) -- display icons in nerdtree
	use({ "tiagofumo/vim-nerdtree-syntax-highlight", requires = { { "preservim/nerdtree" } } }) -- display folders and files with diferent font colors and styles

	-- Latex
	use("lervag/vimtex")
	use({
		"kdheepak/cmp-latex-symbols",
		requires = {
			{ "hrsh7th/nvim-cmp" },
		},
	})

	-- UTILS: utility plugins to make my life easier :)
	use({ -- Commenting, easily and smartly comment with some keymaps
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("norcalli/nvim-colorizer.lua") -- Color display (shows the color when the text it's #ff0000 and so on)
	use({ -- Use treesitter to autoclose and autorename html tag. It work with html,tsx,vue,svelte,php,rescript.
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	}) -- completion of (), [], {} and so on
	use("lewis6991/gitsigns.nvim") -- visual indicator for git repositories
  use("tpope/vim-fugitive") -- tons of commands to work with git

	use({ -- preview markdown files (useful when writting READMEs)
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({ -- brackets and parenthesis and so on indicators
		"p00f/nvim-ts-rainbow",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use({ -- Allows you to modify multi lines visually like shift+alt+a in vsco**
		"mg979/vim-visual-multi",
		branch = "master",
	})

	-- REACT, TSX, ETC
	use({ -- tailwind completion
		"mrshmllow/document-color.nvim",
		config = function()
			require("document-color").setup({ mode = "background" })
		end,
	})

	-- Completion and general doc stuff for different languages: Typescript, Python, c++, etc.
	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
