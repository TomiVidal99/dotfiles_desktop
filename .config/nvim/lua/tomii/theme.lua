-- Styles and visual appearance 
-- TODO: change the name of the tabs.
-- TODO: migrate different config to different files.
--require("tomii.tabs")

local n_ok, n = pcall(require, "neosolarized")
if (not n_ok) then
  print "ERROR: neosolarizd not found. Called from theme.lua"
  return
end

local cb_ok, cb = pcall(require, "colorbuddy.init")
if (not cb_ok) then
  print "ERROR: colorbuddy not found. Called from theme.lua"
  return
end

-- Indentations
vim.opt.list = true
vim.opt.listchars:append "eol:↴"
local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if (not indent_blankline_ok) then
  print "ERROR: indent_blankline not found. Called from theme.lua"
  return
end
indent_blankline.setup({ 
  show_end_of_line = true,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}) -- enable identation lines

n.setup({
  comment_italics = true,
})

-- Modified colors
cb.Color.new('base03', '#002b36')
cb.Color.new('base02', '#073642')
cb.Color.new('base01', '#586e75')
cb.Color.new('base00', '#255667') -- background secondary
cb.Color.new('base0', '#839496')
cb.Color.new("base1", "#586e75")
cb.Color.new('base2', '#2c2cbf')
cb.Color.new('base3', '#7922a8')
cb.Color.new('yellow', '#b58900')
cb.Color.new('orange', '#cb4b16')
cb.Color.new('red', '#dc322f')
cb.Color.new('magenta', '#d33682')
cb.Color.new('violet', '#6c71c4')
cb.Color.new('blue', '#268bd2')
cb.Color.new('cyan', '#2aa198') -- This is the text (strings) color 
cb.Color.new('green', '#719e07')

local colors = cb.colors
local Group = cb.Group
local groups = cb.groups
local styles = cb.styles

local cError = groups.Error.fg
local cInfo = groups.Information.fg
local cWarn = groups.Warning.fg
local cHint = groups.Hint.fg

-- TODO: maybe

-- TODO
-- list of colors to apply to increasing indentation
--local identation_colors = {
--  colors.base2,
--  colors.base3,
--  colors.yellow,
--  colors.orange,
--  colors.red,
--  colors.violet,
--  colors.magenta,
--  colors.blue,
--  colors.green,
--  colors.cyan
--}
--for color in pairs(identation_colors) do
--  print(string.format(color))
--end
--vim.opt.termguicolors = true
--vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
--
--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"
--
--require("indent_blankline").setup {
--    space_char_blankline = " ",
--    char_highlight_list = {
--        "IndentBlanklineIndent1",
--        "IndentBlanklineIndent2",
--        "IndentBlanklineIndent3",
--        "IndentBlanklineIndent4",
--        "IndentBlanklineIndent5",
--        "IndentBlanklineIndent6",
--    },
--}

-- BASE
Group.new("Todo", colors.magenta, colors.none, styles.BOLD + styles.ITALIC)
Group.new("CursorLine", colors.none, colors.base03, styles.none, colors.base1) -- current horizontal line background
Group.new("CursorLineNr", colors.base03, colors.base01, styles.BOLD, colors.base1) -- current line left side number
Group.new("Visual", colors.none, colors.base03, styles.reverse)
Group.new("LineNr", colors.none, colors.base02, styles.none) -- left side number bar vertical
Group.new("Tabline", colors.none, colors.base03, styles.none) -- tabs with text
Group.new("TablineFill", colors.base02, colors.base02, styles.none) -- space left without tabs
Group.new("TablineSel", colors.base03, colors.base01, styles.BOLD) -- tab selected
Group.new("StatusLine", colors.none, colors.base02, styles.BOLD) -- status line down in the bottom

-- DIAGNOSTICS
Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

-- TELESCOPE
Group.new('TelescopePromptBorder', colors.base00)
Group.new('TelescopeSelectionCaret', colors.base3)

-- TREE SITTER
Group.new('TSVariable', colors.yellow, colors.none, styles.italic)

-- TSX
Group.new('tsxTSKeyword', colors.violet, colors.none, styles.none)
Group.new('tsxTSConstructor', colors.blue, colors.none, styles.none)
