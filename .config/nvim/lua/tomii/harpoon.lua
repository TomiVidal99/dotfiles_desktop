-- Creates the module
local M = {}
M.gotoBuffer1 = function() end
M.gotoBuffer2 = function() end
M.gotoBuffer3 = function() end
M.gotoBuffer4 = function() end
M.appendBuffer = function() end
M.toggleQuickMenu = function() end

local harpoon_ok, harpoon = pcall(require, "harpoon")
if not harpoon_ok then
	print("ERROR: harpoon is not available. Called from harpoon.lua")
	return M
end

harpoon:setup()

local function gotoBuffer1()
	harpoon:list():select(1)
end
local function gotoBuffer2()
	harpoon:list():select(2)
end
local function gotoBuffer3()
	harpoon:list():select(3)
end
local function gotoBuffer4()
	harpoon:list():select(4)
end

local function appendBuffer()
	harpoon:list():append()
end

local function toggleQuickMenu()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end

-- Rewrites the functions if the plugins exists
M.gotoBuffer1 = gotoBuffer1
M.gotoBuffer2 = gotoBuffer2
M.gotoBuffer3 = gotoBuffer3
M.gotoBuffer4 = gotoBuffer4
M.appendBuffer = appendBuffer
M.toggleQuickMenu = toggleQuickMenu

return M
