-- Styles and visual appearence

local status_ok = pcall(vim.cmd, "colorscheme NeoSolarized")
if not status_ok then
  print "ERROR: couldn't find the theme"
  return
end

vim.cmd "set background=dark" -- force dark mode
vim.cmd "hi Normal guibg=NONE ctermbg=NONE" -- Set the background to transparent
-- Some theming options
vim.g.neosolarized_contrast = "normal"
vim.g.neosolarized_visibility = "low"
vim.g.neosolarized_vertSplitBgTrans = 1
vim.g.neosolarized_bold = 1
vim.g.neosolarized_underline = 1
vim.g.neosolarized_italic = 1
vim.g.neosolarized_termBoldAsBright = 1
