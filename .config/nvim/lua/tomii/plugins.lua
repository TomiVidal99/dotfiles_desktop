-- Loads plugins.
-- I use lazy.nvim, more info: https://github.com/folke/lazy.nvim

-- adds lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- TODO: i don't know if i want to keep this
-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile> | PackerSync
--  augroup end
--]])

-- Use a protected call so we don't error out on first use
local status_ok, lazynvim = pcall(require, "lazy")
if not status_ok then
	print("ERROR: expected lazy.nvim to be available. Called from plugins.lua")
	return
end

-- TODO: in the docs says that the leader key must be set before calling lazynvim.setup
vim.g.mapleader = " "

-- Install and configurate plugins
lazynvim.setup({
	-- BASE PLUGINS
	"nvim-lua/popup.nvim", --An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua function used in lots of plugins

	-- THEME
	{
		"svrana/neosolarized.nvim", -- actual theme
		dependencies = { "tjdevries/colorbuddy.nvim" },
	},
	"lukas-reineke/indent-blankline.nvim", -- identation lines
	"nvim-lualine/lualine.nvim", -- status line down below
	"fgheng/winbar.nvim", -- winbar
	{
		-- tab theme
		"kdheepak/tabline.nvim",
		dependencies = {
			--{ "hoob3rt/lualine.nvim" },
			"nvim-lua/lsp-status.nvim",
		},
	},

	-- LSP
	{ -- general config for the LSP
		"williamboman/nvim-lsp-installer",
		"neovim/nvim-lspconfig",
	},
	{
		-- LSP loading display
		"j-hui/fidget.nvim",
		tag = "legacy",
	},
	{ -- better UI for LSP related
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		-- icons
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({})
		end,
	},
	{
		-- Type checking
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- disable rtp plugin, as we only need its queries for mini.ai
					-- In case other textobject modules are enabled, we will load them
					-- once nvim-treesitter is loaded
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					load_textobjects = true
				end,
			},
		},
		cmd = { "TSUpdateSync" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		---@type TSConfig
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)

			if load_textobjects then
				-- PERF: no need to load the plugin, if we only need its queries for mini.ai
				if opts.textobjects then
					for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
						if opts.textobjects[mod] and opts.textobjects[mod].enable then
							local Loader = require("lazy.core.loader")
							Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
							local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
							require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
							break
						end
					end
				end
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		init = function()
			-- disable rtp plugin, as we only need its queries for mini.ai
			-- In case other textobject modules are enabled, we will load them
			-- once nvim-treesitter is loaded
			require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
			load_textobjects = true
		end,
	},
	"nvim-treesitter/playground", -- adds type checking and other things to treesitter
	"jose-elias-alvarez/null-ls.nvim", -- more lsp stuff: completion, formatting and so one, that some lsp dont come with
	{ -- lets you manage external tools like LSPs, DAP servers, etc. without the need of you having to install the binaries independenlty.
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	"MunifTanjim/eslint.nvim",
	"MunifTanjim/prettier.nvim",

	-- COMPLETION
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline" },
	},
	"hrsh7th/cmp-nvim-lua", -- completion for lua inside nvim

	-- SPELL CHECKING
	"f3fora/cmp-spell",
	-- use "uga-rosa/cmp-dictionary" -- dictionary

	-- SNIPPETS
	{ "L3MON4D3/LuaSnip", dependencies = "saadparwaiz1/cmp_luasnip" }, -- snippet engin
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- Navigation
	{
		-- general navigation
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		config = function()
			require("telescope").setup({ defaults = { file_ignore_patterns = { "node_modules", ".git" } } })
		end,
	},
	"preservim/nerdtree", -- file explorer
	{ "Xuyuanp/nerdtree-git-plugin", dependencies = { "preservim/nerdtree" } }, -- displays git status on nerdtre
	{ "ryanoasis/vim-devicons", dependencies = { "preservim/nerdtree" } }, -- display icons in nerdtre,
	-- TODO: this causes errors, gotta wait until they fix it
	--{ "tiagofumo/vim-nerdtree-syntax-highlight", dependencies = { { "preservim/nerdtree" } } }) -- display folders and files with diferent font colors and style,

	-- Latex
	"lervag/vimtex",
	{
		"kdheepak/cmp-latex-symbols",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},

	-- UTILS: utility plugins to make my life easier
	{
		-- Commenting, easily and smartly comment with some keymaps
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"norcalli/nvim-colorizer.lua", -- Color display (shows the color when the text it's #ff0000 and so on)
	{
		-- Use treesitter to autoclose and autorename html tag. It work with html,tsx,vue,svelte,php,rescript.
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	}, -- completion of (), [], {} and so o,
	"lewis6991/gitsigns.nvim", -- visual indicator for git repositories
	"tpope/vim-fugitive", -- tons of commands to work with git

	{
		-- preview markdown files (useful when writting READMEs)
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		-- brackets and parenthesis and so on indicators
		"p00f/nvim-ts-rainbow",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- {
	-- 	-- Allows you to modify multi lines visually like shift+alt+a in vsco**
	-- 	"mg979/vim-visual-multi",
	-- 	branch = "master",
	-- },

	-- REACT, TSX, ETC
	{
		-- tailwind completion
		"mrshmllow/document-color.nvim",
		config = function()
			require("document-color").setup({ mode = "background" })
		end,
	},

	-- Completion and general doc stuff for different languages: Typescript, Python, c++, etc.
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
	},

	-- To be able to work with jupyter in neovim
	{
		"meatballs/notebook.nvim",
		config = function()
			require("notebook").setup()
		end,
	},
})
