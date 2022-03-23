function [interval] = intpi(len = 10, step = 1)
  % returns an interval between -len*pi and len*pi with a step as step*pi by default.
  % its equivalen to having the hole interval multiplied by pi.
  a = len*pi;
  da = step*pi;
  interval = [-a:da:a];
end
