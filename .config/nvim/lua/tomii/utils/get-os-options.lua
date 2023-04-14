local M = {}

--
-- Returns the working shell depending on the current OS.
-- @return string
M.get_os_shell = function()
  local is_linux = require("tomii.utils.check-os")
  if is_linux() then
    return "zsh"
  else
    return "cmd.exe"
  end
end

return M
