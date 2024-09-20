function [plotNumber] = simplePlot(
  n, x,  % señal
  plotTitle, % titulo
  savePlots = 0, savePath = '', % si se guarda el grafico
  labels = {'n', 'y[n]'}, % ejes personalizados
  customLimits = {} % limites personalizados
)
  % Función utilitaria para graficar un solo plot.

  % Nueva ventana
  plotNumber = figure('name', plotTitle);

  % Mensaje de logeo.
  dispc(
    cstrcat('Creando gráfico: ', plotTitle, '.\n'),
    'blue'
  );

  % x puede ser un vector o una función anónima.
  if (strcmp(typeinfo(x), 'matrix') == 1 || strcmp(typeinfo(x), 'bool matrix') == 1 || strcmp(typeinfo(x), 'complex matrix') == 1)
    stem([1:length(n)], x, 'b', 'linewidth', 2, 'filled');
  else
    stem(n, x(n), 'b', 'linewidth', 2, 'filled');  
  end

  % Configuro los limites para que sean acordes al gráfico.
  if (length(customLimits) != 0)
    xlim(customLimits{1});
    ylim(customLimits{2});
    if (length(customLimits) > 2)
      xbounds = xlim(); ybounds = ylim();
      set(gca, 'xtick', xbounds(1):customLimits{3}:xbounds(2));
      set(gca, 'ytick', ybounds(1):customLimits{4}:ybounds(2));
    end
  end

  % Título y ejes.
  title(plotTitle);
  xlabel(labels{1});
  ylabel(labels{2});
  grid on;

  % Guardo el gráfico.
  if (savePlots == 1)
    dispc(cstrcat("Se guardará '", savePath, "'\n"), 'yellow');
    print(savePath);
  end

end
