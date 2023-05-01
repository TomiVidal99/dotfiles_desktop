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
				"--background-index",
				"--suggest-missing-includes",
				'--query-driver="/usr/local/opt/gcc-arm-none-eabi-8-2019-q3-update/bin/arm-none-eabi-gcc"',
        "-I/usr/include/gtk-4.0",
        "-I/usr/include/pango-1.0",
        "-I/usr/include/glib-2.0",
        "-I/usr/lib/glib-2.0/include",
        "-I/usr/include/sysprof-4",
        "-I/usr/include/harfbuzz",
        "-I/usr/include/freetype2",
        "-I/usr/include/libpng16",
        "-I/usr/include/libmount",
        "-I/usr/include/blkid",
        "-I/usr/include/fribidi",
        "-I/usr/include/cairo",
        "-I/usr/include/pixman-1",
        "-I/usr/include/gdk-pixbuf-2.0",
        "-I/usr/include/graphene-1.0",
        "-I/usr/lib/graphene-1.0/include",
        "-mfpmath=sse",
        "-msse",
        "-msse2",
        "-pthread",
        "-lgtk-4",
        "-lpangocairo-1.0",
        "-lpango-1.0",
        "-lharfbuzz",
        "-lgdk_pixbuf-2.0",
        "-lcairo-gobject",
        "-lcairo",
        "-lgraphene-1.0",
        "-lgio-2.0",
        "-lgobject-2.0",
        "-lglib-2.0",
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
