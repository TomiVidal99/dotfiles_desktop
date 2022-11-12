local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  print "ERROR: nvim-lsp-installer not available. Called from lsp-installer.lua"
  return
end
local lsp_configs_ok, lsp_configs = pcall(require, "lspconfig/configs")
if not lsp_configs_ok then
  print "ERROR: lspconfig/configs not available. Called from lsp-installer.lua"
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

-- Error that throws clangd
capabilities.offsetEncoding = "utf-8"

-- Define locallly the lsp
local lsp = require("lspconfig")
local lsps_opts = {on_attach = on_attach, capabilities = capabilities}

-- Server for cpp/c
lsp.clangd.setup(lsps_opts)

-- Server for javascript, typescript, react javascript and react typescript.
lsp.tsserver.setup(lsps_opts)

-- General diagnostics for most languages
lsp.diagnosticls.setup(lsps_opts)

-- Tailwindcss support, shows colors and completion
lsp.tailwindcss.setup(lsps_opts)

-- For html kinda of snippets
lsp.emmet_ls.setup(lsps_opts)

-- For css, scss and less
lsp.cssls.setup(lsps_opts)

-- Python
lsp.pyright.setup(lsps_opts)

-- Server language for lua.
lsp.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = require("tomii.lsp.settings.sumneko_lua"),
})

-- CUSTOM LSPS

-- mlang
-- vim.lsp.start({
--   name = "mlang",
--   cmd = {"/home/tomii/programming/lsp_mlang/run.sh"},
--   filetypes = { "matlab", "octave" },
--   root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
--   settings = {},
-- })
