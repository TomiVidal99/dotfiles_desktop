function [req] = rpar(r1, r2)
  % Function that returns the pararel equivalent resistance between resistor r1 and r2.
  req = 1/(1/r1+1/r2);
end
