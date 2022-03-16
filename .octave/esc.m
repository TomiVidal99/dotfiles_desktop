function [ESC] = esc(n)
  esc = @(t) (t>=-.5).*(t<=.5);
  ESC = esc(n);
end
