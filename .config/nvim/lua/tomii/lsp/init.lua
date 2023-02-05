-- First check if the user has LSP.
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("ERROR: no support for native LSP, install 'neovim/nvim-lspconfig'. Called from 'lua/tomii/lsp/init.lua'.")
  return
end
local lsp_installer_ok, _ = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	print("ERROR: nvim-lsp-installer not available. Called from 'lua/tomii/lsp/init.lua'.")
	return
end
local lspconfig_configs_ok, _ = pcall(require, "lspconfig.configs")
if not lspconfig_configs_ok then
	print("ERROR: lspconfig/configs not available. Called from 'lua/tomii/lsp/init.lua'.")
	return
end

require("tomii.lsp.lsp-installer")
require("tomii.lsp.handlers").setup()
