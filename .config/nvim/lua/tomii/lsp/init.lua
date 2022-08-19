-- First check if the user has LSP.
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("ERROR: no support for native LSP, install 'neovim/nvim-lspconfig'. Called from 'lua/tomii/lsp.lua'.")
  return
end

require("tomii.lsp.lsp-installer")
require("tomii.lsp.handlers").setup()
