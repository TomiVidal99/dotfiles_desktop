function [a,b,c] = abChebyshev(n, e, A = 1)
    % Se calculan las raices de un polinomio para Chebyshev
    % function [a,b,c] = abChebyshev(n, e, A = 1)
    %

    arg0 = sqrt(A/(e^2)+1) + sqrt(A)/e;
    arg1 = arg0^(1/n);
    arg2 = arg0^(-1/n);
    arg = arg1-arg2;

    k = 1;
    m = 1;
    while (k <= 4*n-1)
      a(m) = 0.5*sin((2*k-1)*pi/(2*n))*arg;
      b(m) = 0.5*cos((2*k-1)*pi/(2*n))*arg;
      c(m) = a(m) + j*b(m);
      k=k+2;
      m=m+1;
    end

end
