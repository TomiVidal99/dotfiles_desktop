local lspconfig = require("lspconfig")
local lspconfig_config = require("lspconfig.configs")

-- VHDL: Manual add rust_hdl server
if not lspconfig_config.rust_hdl then
	lspconfig_config.rust_hdl = {
		default_config = {
			name = "vhdl_ls",
			cmd = { "vhdl_ls" },
			filetypes = { "vhdl" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("vhdl_ls.toml")(fname) or vim.fn.getcwd()
			end,
			settings = {},
		},
	}
end
-- lspconfig.rust_hdl.setup(lsps_opts)

-- VHDL: hdl_checker
if not lspconfig_config.hdl_checker then
	lspconfig_config.hdl_checker = {
		default_config = {
			name = "hdl_checker",
			cmd = { "hdl_checker", "--lsp" },
			filetypes = { "vhdl", "verilog", "systemverilog" },
			root_dir = function(fname)
				-- will look for the .hdl_checker.config file in parent directory, a
				-- .git directory, or else use the current directory, in that order.
				local util = lspconfig.util
				return util.root_pattern(".hdl_checker.config")(fname)
					or util.find_git_ancestor(fname)
					or util.path.dirname(fname)
			end,
			settings = {},
		},
	}
end

-- Bash
if not lspconfig_config.bash_language_server then
	lspconfig_config.bash_language_server = {
		default_config = {
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh" },
			root_dir = function()
				return vim.fn.getcwd()
			end,
			-- settings = {},
		},
	}
end

-- mlang
if not lspconfig_config.mlang then
	local mlang_server = "/home/tomii/Github/mlang/out/server.js"
	lspconfig_config.mlang = {
		default_config = {
			name = "mlang",
			cmd = { "node", mlang_server, "--stdio" },
			filetypes = { "matlab", "octave", "m" },
			--root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
			root_dir = function()
				return vim.fn.getcwd()
			end,
			settings = {
				settings = {
					maxNumberOfProblems = 1000,
				},
			},
		},
	}
end
