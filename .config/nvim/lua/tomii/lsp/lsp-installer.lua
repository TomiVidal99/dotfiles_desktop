local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Import options from the other files
local on_attach = require("tomii.lsp.handlers").on_attach
local capabilities = require("tomii.lsp.handlers").capabilities

-- Register a handler that will be called for all installed servers.
lsp_installer.setup({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

-- Define locallly the lsp
local lsp = require("lspconfig")

-- Server for javascript, typescript, react javascript and react typescript.
lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- General diagnostics for most languages
lsp.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Server language for lua.
lsp.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = require("tomii.lsp.settings.sumneko_lua"),
}
