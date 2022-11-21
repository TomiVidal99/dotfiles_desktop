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
local lsps_opts = {on_attach = on_attach, capabilities = capabilities}

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
lsp.omnisharp.setup({
  -- TODO: move all this config to a different directory
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { omnisharp_executable, "--languageserver" , "--hostPID", tostring(pid) },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = false,
  enable_import_completion = false,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
})

-- VHDL
if not require'lspconfig.configs'.hdl_checker then
  require'lspconfig.configs'.hdl_checker = {
    default_config = {
    cmd = {"hdl_checker", "--lsp", };
    filetypes = {"vhdl", "verilog", "systemverilog"};
      root_dir = function(fname)
        -- will look for the .hdl_checker.config file in parent directory, a
        -- .git directory, or else use the current directory, in that order.
        local util = require'lspconfig'.util
        return util.root_pattern('.hdl_checker.config')(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
      end;
      settings = {};
    };
  }
end
require'lspconfig'.hdl_checker.setup{}
