function plotSignalAndFFT(
    N, signal, s, fft,
    signalName,
    overrideSignalXlabel = 0
  )
  %{
  Utility function to setup a plot with the signal and its fft in absolute and fase.
  - Definition: plotSignalAndFFT(
    N, signal, s, fft,
    signalName,
    overrideSignalXlabel = 0,
  ) 
  - Types:
    N (VECTOR)
    signal (VECTOR)
    s (VECTOR)
    fft (VECTOR)
    overrideSignalXlabel (STRUCT) = {xlabel, ylabel}
  %}

  % Log message.
  dispc(cstrcat("Creando gráfico de '", signalName, "' \n"), "blue");

  % New window
  figureNumber = figure('name', signalName);

  % Setup plot and graph signal.
  subplot(2, 2, 1:2, "align");
  stem(N, signal, 'b', 'linewidth', 2);

  % Axis names.
  if (iscell(overrideSignalXlabel) == 0)
    subplotConfig(signalName, 'n', cstrcat(signalName, '[n]'), 0);
  else 
    subplotConfig(signalName, overrideSignalXlabel{1}, cstrcat(signalName, overrideSignalXlabel{2}), 0);
  end

  % Setup plot of the signal fft.
  subplot(2, 2, 3);
  stem(s, abs(fft), 'r', 'linewidth', 2);
  subplotConfig(cstrcat('Módulo de fft\{', signalName, '\}'), 's', cstrcat('|fft\{', signalName, '\}|'), 0);
  %xlim([-.5, .5]);
  %set(gca,'XTick',-.5:.25:.5);
  grid on;

  % Fase of the signal fft.
  subplot(2, 2, 4);
  plot(s, angle(fft)/pi, 'r', 'linewidth', 2);
  subplotConfig(cstrcat('Fase de fft\{', signalName, '\}'), 's', cstrcat('∠fft\{', signalName, '\}(s)'), 0);
  xlim([-.5, .5]); set(gca,'XTick',-.5:0.25:.5);
  ylim([-1, 1]); set(gca, 'yticklabel', interval2string([-1:.5:1], '\pi'));
  grid on;

end
