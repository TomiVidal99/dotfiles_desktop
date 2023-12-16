function [fpb] = transFreq(f, f0)
  % Transforma una frecuencia de un pasa banda a un pasa bajos
  % Espera que se le entregue una frecuencia a
  % transformar y la frecuencia central de la banda de paso
  % function [fpb] = transFreq(f, f0)
  %

  if (f == 0)
    dispc("f no puede ser cero", "red");
    fpb = NaN;
    return;
  else
    fpb = (f*f-(f0*f0))/f;
  end

end
