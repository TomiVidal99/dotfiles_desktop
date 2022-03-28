function deltas = Delta(n)
  % Deltas de Dirac y de Kronecker.
  % n es el unico argumento, y es el intervalo en que se evalua.
  % No hay diferencia entre la de Delta de Dirac y de Kronecker, lo unico es el intervalo considerado.
  % uso: deltasDeKronecker = dd([-10:10]);
  % plot([-10:10], deltasDeKronecker)

  delta = @(x) (x==0);

  deltas = delta(n);

end
