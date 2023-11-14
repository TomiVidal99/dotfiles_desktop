local gs_ok, gs = pcall(require, "gitsigns")
if not gs_ok then
	print("ERROR: gitsigns not available. Called from gitsigns.lua")
	return
end

gs.setup()
