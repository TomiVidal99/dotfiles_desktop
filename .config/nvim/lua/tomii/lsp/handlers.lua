local HANDLERS = {}

HANDLERS.setup = function()

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_color_provider(client, bufnr)
  if client.server_capabilities.colorProvider then
    -- Attach document colour support
    local dc_ok, dc = pcall(require, "document-color")
    if not dc_ok then
      print "ERROR: lsp_color_provider failed to require 'document-color'. Called from handlers.lua"
      print(dc)
      return
    end
    dc.buf_attach(bufnr)
  end
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

-- MAPPINGS
local function lsp_keymaps(bufnr)

  local buffer_opts = { noremap = true, silent = true, buffer = bufnr }
  local function keymap_buf(key, fn) vim.keymap.set("n", key, fn, buffer_opts) end

  keymap_buf('gr', '<CMD>lua vim.lsp.buf.references()<CR>')
  keymap_buf('gD', '<CMD>lua vim.lsp.buf.declaration()<CR>')
  keymap_buf('gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
  keymap_buf('gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
  keymap_buf('<leader>dd', '<CMD>lua vim.lsp.buf.type_definition()<CR>')
  keymap_buf('<leader>rr', '<CMD>lua vim.lsp.buf.rename()<CR>')
  keymap_buf("<leader>ff", "<CMD>lua vim.lsp.buf.formatting()<CR>")

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

HANDLERS.on_attach = function(client, bufnr)
  -- TODO: check if i keep this
  --if client.name == "tsserver" then
  --  client.resolved_capabilities.document_formatting = false
  --end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  lsp_color_provider(client, bufnr) -- for tailwindcss
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

HANDLERS.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
HANDLERS.capabilities.textDocument.colorProvider = true -- this is to enable the tailwindcss plugin

return HANDLERS
