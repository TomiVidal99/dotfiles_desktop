function [raices, polinomio] = chebyshev(n=0, eps=0, A=1, graph=0)
  % Devuelve las raices del polinomio de Chebyshev: A + e^2*Vn(w)^2
  % Puede graficar también si se le provee graph=1
  % Argumentos de: function [alphas, betas] = chebyshev(n=0, eps= A=1)
  % - n (orden del polinomio)
  % - eps (epsilon)
  % - A
  % - graph=0 (si se grafica o no, 1 para que si grafique)
  %
  % Retorna:
  % raices -> Array
  % polinomio

  raices = NaN;
  polinomio = NaN;

  if (n <= 0 || eps <= 0)
    help chebyshev;
  end

  k = [1:2*n];
  _2n = 2*n;

  eps2 = eps*eps;
  _1n_1 = (sqrt(A/eps2+1) + sqrt(A)/eps)^(1/n);
  _1n_1_inverted = _1n_1^(-1);
  chocloAlphas = _1n_1 - _1n_1_inverted;
  chocloBetas = _1n_1 + _1n_1_inverted;

  alphas = [1:length(k)];
  betas = [1:length(k)];
  for (i = 1:length(k))
    alphas(i) = 0.5*sin((2*k(i)-1)*pi/_2n)*chocloAlphas;
    betas(i) = 0.5*cos((2*k(i)-1)*pi/_2n)*chocloBetas;
    raices(i) = alphas(i) + j*betas(i);
  end

  raices = transpose(raices);

  if (graph)
    plot(alphas, betas, 'x', 'linewidth', 4);
  end

  pkg load control;
  s = tf('s');
  complexConjugated = s^2 + 2*alphas(1)*s + alphas(1)^2 + betas(1)^2;
  polinomio = complexConjugated * (s+alphas(2));

end
