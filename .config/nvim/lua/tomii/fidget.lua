-- Loading status of the LPS, more info: https://github.com/j-hui/fidget.nvim
local status, fidget = pcall(require, "fidget")
if not(status) then
  print "ERROR: plugin figet could not be found. At fidget.lua"
end

fidget.setup({
  text = {
    spinner = "dots",         -- animation shown when tasks are ongoing
  },
  window = {
    blend = 0,              -- &winblend for the window
  },
})
