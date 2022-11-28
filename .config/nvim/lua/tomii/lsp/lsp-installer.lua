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
      server_uninstalled = "✗",
    },
  },
})

-- Define locallly the lsp
local lsp = require("lspconfig")
local lsps_opts = { on_attach = on_attach, capabilities = capabilities }

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

-- C#
local pid = vim.fn.getpid()
local omnisharp_executable = "omnisharp"
local root_pattern = require("lspconfig.util").root_pattern
lsp.omnisharp.setup({
  -- TODO: move all this config to a different directory
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function(path)
    return root_pattern("*.sln")(path) or root_pattern("*.csproj")(path)
  end,
  cmd = { omnisharp_executable, "--languageserver", "--hostPID", tostring(pid) },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Manual add rust_hdl server
if not configs.rust_hdl then
  configs.rust_hdl = {
    default_config = {
      cmd = { "vhdl_ls" },
      filetypes = { "vhdl" },
      root_dir = function(fname)
        return lspconfig.util.root_pattern("vhdl_ls.toml")(fname) or vim.fn.getcwd()
      end,
      settings = {},
    },
  }
end
lsp.rust_hdl.setup({
  on_attach = on_attach,
  capabilities = capabilities
})
