local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	print("ERROR: 'mason' not found. Called from mason.lua")
end
mason.setup()
local masonconfig_ok, masonconfig = pcall(require, "mason-lspconfig")
if not masonconfig_ok then
	print("ERROR: 'mason-lspconfig.nvim' not found. Called from mason.lua")
end
-- first i get the custom lspconfig lsp settings
require("tomii.lsp.settings.custom_settings")
masonconfig.setup({
  ensure_installed = { "tsserver", "clangd", "diagnosticls" }
})
