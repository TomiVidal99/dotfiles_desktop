-- Styles and visual appearence

local status_ok = pcall(vim.cmd, "colorscheme NeoSolarized")
if not status_ok then
  print "ERROR: couldn't find the theme"
  return
end

vim.cmd "set background=dark" -- force dark mode
