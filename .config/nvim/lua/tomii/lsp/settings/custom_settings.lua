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
-- vim.lsp.start({
--   name = "mlang",
--   cmd = {"/home/tomii/programming/lsp_mlang/run.sh"},
--   filetypes = { "matlab", "octave" },
--   root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
--   settings = {},
-- })
