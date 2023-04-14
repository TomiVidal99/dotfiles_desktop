function [CAJ] = caj(n)
  caj = @(t) (t>=-.5).*(t<=.5);
  CAJ = caj(n);
end
