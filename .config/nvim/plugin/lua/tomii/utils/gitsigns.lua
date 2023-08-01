-- Visual indicators for the status of the current git repository.
local status_ok, gitsigns= pcall(require, "gitsigns")
if not status_ok then
  print "ERROR: gitsigns is not available. Called from gitsigns.lua"
  return
end

-- Settings
gitsigns.setup()
