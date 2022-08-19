-- Visual indicators for the status of the current git repository.
local status_ok, vgit = pcall(require, "vgit")
if not status_ok then
  print "ERROR: vgit is not available. Called from vgit.lua"
  return
end

-- Initialize the plugin
vgit.setup()
