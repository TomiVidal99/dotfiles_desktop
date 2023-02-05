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
	},
	playground = {
		enable = true,
	},
})
