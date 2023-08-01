-- Settings for the sumneko_lua LSP
local settings = {
  Lua = { -- improvements when working with Lua inside nvim
    runtime = { version = 'LuaJIT' }, -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    diagnostics = { globals = { 'vim' } }, -- Get the language server to recognize the `vim` global
    workspace = { library = vim.api.nvim_get_runtime_file("", true) }, -- Make the server aware of Neovim runtime files
    telemetry = { enable = false }, -- Do not send telemetry data containing a randomized but unique identifier
  },
}

return settings
