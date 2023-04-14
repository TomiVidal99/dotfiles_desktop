local M = {}

local is_linux = require("tomii.utils.check-os")

---Returns the command to open a new terminal in a new tab.
-- @return string
M.get_new_tab_terminal = function()
  if is_linux() then
    return "<CMD>tabedit term://zsh | tabmove 0<CR>"
  else
    return "<CMD>tabedit term://cmd.exe | tabmove 0<CR>"
  end
end
--
---Returns the command to open a new terminal at the right side of the current tab.
-- @return string
M.get_right_terminal = function()
  if is_linux() then
    return "<CMD>vsplit term://zsh<CR>"
  else
    return "<CMD>vsplit term://cmd.exe <CR>"
  end
end

---Returns the command to open a new terminal at the bottom of the current tab.
-- @return string
M.get_bottom_terminal = function()
  if is_linux() then
    return "<CMD>split term://zsh | resize 10<CR>"
  else
    return "<CMD>split term://cmd.exe | resize 10<CR>"
  end
end

return M
