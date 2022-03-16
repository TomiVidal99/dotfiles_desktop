function [U] = u(n)
  escalon = @(t) (t >= 0);
  U = escalon(n);
end
