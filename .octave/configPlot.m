function configPlot(Figure = 1, Title = "Gráfico 1", limits = "auto", step = 1, fontsize = 14, linewidth = 2)
  # Default parameters configPlot(Figure = 1, Title = "Gráfico 1", limits = "auto", step = 1, fontsize = 14, linewidth = 2)
  # Función utilitaria para configurar los plots.
  figure(Figure);
  title(Title);
  grid on;
  hold on;
  axis(limits);
  set(gca, "linewidth", linewidth, "fontsize", fontsize);
  xbounds = xlim();
  set(gca, "xtick", xbounds(1):step:xbounds(2));
end
