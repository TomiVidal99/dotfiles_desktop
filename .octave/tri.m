function [TRI] = tri(n)
  tri = @(t) (1-t).*(t<=1).*(t>=0)+(1+t).*(t<0).*(t>=-1);
  TRI = tri(n);
end
