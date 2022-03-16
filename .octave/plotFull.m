function plotFull(t, x, axis_limits, xaxis, yaxis, title, fontsize = 12, colour, lineweight = 2)
  % Parametros por defecto: plotFull(t, x, axis_limits, xaxis, yaxis, title, fontsize = 12, colour, lineweight = 2)
  % Function para plotear con configuracion integrada.
  figure('units', 'normalized', 'outerposition', [0 0 1 1]); % Creo y maximizo figura.
  plot(t, x, colour, 'Linewidth', lineweight); % Grafico. colouror (y marcador) y lineweight.
  axis(axis_limits);
  grid on;
  % Lı́mites de los ejes. Grilla.
  set(gca, 'FontSize', fontsize);
  % Tamaño de letra para la leyenda y ejes.

  % Nombro el eje x.
  xlabel(xaxis ,'Interpreter', 'Latex');

  % Nombro el eje y.
  ylabel(yaxis, 'Interpreter', 'Latex');

  % color tı́tulo para el gráfico.
  title(title);
end
