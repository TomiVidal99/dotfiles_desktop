-- Configuration for tree-sitter (syntax highlight)
local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	print("ERROR: tree-sitter not available. Called from tree-sitter.lua")
	return
end

-- Settings
ts.setup({
	theme = "auto",
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"comment",
		"tsx",
		"lua",
		"json",
		"html",
		"css",
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#32a88d",
      "#326fa8",
      "#91104c",
      "#914c10",
    },
	},
	playground = {
		enable = true,
	},
})

vim.cmd[[hi rainbowcol1 guifg=#123456]]
vim.cmd[[hi rainbowcol2 guifg=#326fa8]]
vim.cmd[[hi rainbowcol3 guifg=#91104c]]
vim.cmd[[hi rainbowcol4 guifg=#914c10]]
