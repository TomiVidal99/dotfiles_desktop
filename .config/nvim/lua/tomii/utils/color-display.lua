-- Displays colors from text like #ff0000

local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  print "ERROR: colorizer not install. Called from utils/color-display.lua"
  return
end

-- initialize
colorizer.setup()
