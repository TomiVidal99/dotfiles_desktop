function [figureNumber] = twoSubplots(windowTitle, s1, s2, xlimits = 'auto', ylimits = 'auto')
  %{
    Utility function to plot two graphs in one window.
    Definition: function [figureNumber] = twoSubplots(windowTitle, s1, s2, options)
    Usage: twoSubplots("signal 1 y 2", signal1, signal2, xlimits, ylimits);
      - windowTitle (STRING)
      - signal1 y signal2 (STRUCT)
        - {(VECTOR), (ANONIMOUS FUNCTION or VECTOR), (STRING)}
        - signal1 = {[1,2,3], @(n) n+1, 'title'}
      - xlimits = (VECTOR) or 'auto'
      - ylimits = (VECTOR) or 'auto'
  %}

  % Check if the parameters of s1 and s2 are good.
  if (
      strcmp(typeinfo(s1{1}), 'matrix') != 1 &&
      strcmp(typeinfo(s1{1}), 'bool matrix') != 1
  )
    dispc('s1{1} is not a vector \n', 'red');
  elseif (
      strcmp(typeinfo(s1{2}), 'matrix') != 1 &&
      strcmp(typeinfo(s1{2}), 'bool matrix') != 1 &&
      strcmp(typeinfo(s1{2}), 'function handle') != 1
  )
    dispc('s1{2} is not a vector nor a anonimous function \n', 'red');
  elseif (strcmp(typeinfo(s1{3}), 'sq_string') != 1)
    dispc('s1{3} is not a string \n', 'red');
  elseif (
      strcmp(typeinfo(s2{1}), 'matrix') != 1 && 
      strcmp(typeinfo(s2{1}), 'bool matrix') != 1
  )
    dispc('s2{1} is not a vector \n', 'red');
  elseif (
      strcmp(typeinfo(s2{2}), 'matrix') != 1 &&
      strcmp(typeinfo(s2{2}), 'bool matrix') != 1 &&
      strcmp(typeinfo(s2{2}), 'function handle') != 1
  )
    dispc('s2{2} is not a vector nor a anonimous function \n', 'red');
  elseif (strcmp(typeinfo(s2{3}), 'sq_string') != 1)
    dispc('s2{3} is not a string \n', 'red');
  end

  % Setup the looks of the graph.
  function setUpPlot()
    xlabel('n');
    grid on;
    if (strcmp(xlimits, 'auto') != 1)
      xlim([-xlimts, xlimts]); %set(gca,'XTick',-xlimts:.25:xlimts);
    end
    if (strcmp(ylimits, 'auto') != 1)
      ylim([-ylimits, ylimits]); %set(gca,'YTick',-ylimits:.25:ylimits);
    end
  end

  % Logging message.
  dispc(
    cstrcat('Creando gráfico ', windowTitle, '.\n'),
    'blue'
  );

  % Creates a new window.
  figureNumber = figure('name', windowTitle);

  % First plot
  subplot(2, 1, 1);
  if (strcmp(typeinfo(s1{2}), 'matrix') == 1)
    plot(s1{1}, s1{2}, 'b', 'linewidth', 3);
  else
    plot(s1{1}, s1{2}(s1{2}), 'b', 'linewidth', 3);
  end
  ylabel(s1{3}); title(s1{3}); setUpPlot();

  % Second plot
  subplot(2, 1, 2);
  if (strcmp(typeinfo(s2{2}), 'matrix') == 1)
    plot(s2{1}, s2{2}, 'b', 'linewidth', 3);
  else
    plot(s2{1}, s2{2}(s2{2}), 'b', 'linewidth', 3);
  end
  ylabel(s2{3}); title(s2{3}); setUpPlot();

end
