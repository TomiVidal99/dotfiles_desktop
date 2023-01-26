-- Status line (lualine)
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print("ERROR: lualine not available. Called from theme.lua")
	return
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

-- Options
lualine.setup({
	extensions = {
		"fzf",
		"neo-tree",
		"fugitive",
		"quickfix",
		"nvim-tree",
	},
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "Outline" },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source } },
		lualine_c = {
			{
				"filename",
				file_status = false,
				newfile_status = false,
				path = 3,
				shorting_target = 40,
			},
		},
		lualine_x = { "diagnostics" },
		lualine_y = { "encoding", "filetype" },
		lualine_z = { "progress", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- tabline = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
})
