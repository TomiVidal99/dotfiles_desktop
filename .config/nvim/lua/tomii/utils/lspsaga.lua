-- Lspsaga configuration
local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  print "ERROR: lspsaga is not available. Called from lspsaga.lua"
  return
end

lspsaga.init_lsp_saga({
  saga_winblend = 1,
  symbol_in_winbar = {
    in_custom = true
  },
  code_action_icon = ' ',
})
