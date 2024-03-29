local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

-- auto format on save
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])

-- Register a handler that will be called for all installed servers.
lsp_installer.setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

-- Import options from the other files
local on_attach = require("tomii.lsp.handlers").on_attach
local capabilities = require("tomii.lsp.handlers").capabilities
local lsps_opts = { on_attach = on_attach, capabilities = capabilities }

-- LPSs
local lsp_list = {
	clangd = {
		name = "clangd",
		opts = {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = {
			  "clangd",
			},
		},
	},
  "tsserver",
	"diagnosticls",
	"tailwindcss",
	"emmet_ls",
	"cssls",
	"pyright",
	"jsonls",
	lua_ls = {
		name = "lua_ls",
		opts = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = require("tomii.lsp.settings.lua_ls"),
		},
	},
}

for _, data in pairs(lsp_list) do
	if type(data) == "string" then
		lspconfig[data].setup(lsps_opts)
	else
		lspconfig[data["name"]].setup(data["opts"])
	end
end

-- TODO: think how to change the lsp_list to accept custom settings
-- LUA
-- lspconfig.lua_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = require("tomii.lsp.settings.lua_ls"),
-- })

-- Custom LSPs
local custom_lsps = {
	"rust_hdl",
	"bash_language_server",
	"hdl_checker",
	"mlang",
}
for _, lsp in pairs(custom_lsps) do
	lspconfig[lsp].setup(lsps_opts)
end

-- mason-lspconfig allows me to automatically configure all installed LPSs
-- Though the configs must exists in the lspconfig.
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		local lsp_data = lsp_list[server_name]
		if lsp_data then
			lspconfig[server_name].setup(lsp_data["opts"])
		else
			lspconfig[server_name].setup(lsps_opts)
		end
	end,
})
