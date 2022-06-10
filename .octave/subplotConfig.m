function subplotConfig(ptitle = "", labelx = "", labely = "", savePlots)
  % función que me permite configurar el gráfico.
  title(ptitle);
  xlabel(labelx);
  ylabel(labely);
  grid on;
  if (savePlots != 1)
    h = gca();
    set(h, 'fontsize', 20, 'linewidth', 1.5, 'fontweight', 'bold');
  end
end
