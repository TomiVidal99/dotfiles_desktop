local windows_name = "Windows_NT"

-- Returns true if the current OS it's linux, false else.
-- @return boolean 
local is_linux = function()
  local current_os = vim.loop.os_uname().sysname
  if (current_os == windows_name) then
    return false
  else
    return true
  end
end

return is_linux
