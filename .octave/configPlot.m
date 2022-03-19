function configPlot(settings = struct())
  % Default parameters ("figure", 1, "title", "Gráfico 1", "limits", "auto", "step", 1, "fontsize", 14, "linewidth", 2, "xlabel", "", "ylabel", "")
  % % Función utilitaria para configurar los plots.
  % figure = 1, title = "Gráfico 1", limits = "auto", step = 1, fontsize = 14, linewidth = 2

  default_settings = struct(
    "figure", 1,
    "title", "Gráfico 1",
    "limits", "auto",
    "step", .2,
    "fontsize", 14,
    "linewidth", 2,
    "xlabel", NaN,
    "ylabel", NaN,
    "xLabelHasPi", 0,
    "yLabelHasPi", 0
  );

  for [val, key] = settings
    default_settings.(key) = val;
  end

  % set default values
  Figure = default_settings.("figure");
  Title = default_settings.("title");
  limits = default_settings.("limits");
  step = default_settings.("step");
  fontsize = default_settings.("fontsize");
  linewidth = default_settings.("linewidth");
  labelX = default_settings.("xlabel");
  labelY = default_settings.("ylabel");
  xLabelHasPi = default_settings.("xLabelHasPi");
  yLabelHasPi = default_settings.("yLabelHasPi");

  figure(Figure); % select the graph
  title(Title); % set title
  grid on; % set grid
  hold on; % preserve changes
  set(gca, "linewidth", linewidth, "fontsize", fontsize); % set linewidth and fontsize

  axis(limits);
  xbounds = xlim();
  ybounds = ylim();
  set(gca, "xtick", xbounds(1):step:xbounds(2));
  set(gca, "ytick", ybounds(1):step:ybounds(2));

  if (isstring(labelX) || ischar(labelX)) 
    intx = [xbounds(1):step:xbounds(2)];
    if (limits != "auto")
      intx = [limits(1):step:limits(2)];
      set(gca, "ytick", intx);
    end
    set(gca, "xticklabel", interval2string(intx, labelX, xLabelHasPi));
  end

  if (isstring(labelY) || ischar(labelY)) 
    inty = [ybounds(1):step:ybounds(2)];
    if (limits != "auto")
      inty = [limits(3):step:limits(4)];
      set(gca, "ytick", inty);
    end
    set(gca, "yticklabel", interval2string(inty, labelY, yLabelHasPi));
  end

end
