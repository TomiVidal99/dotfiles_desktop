function spb = convFreq(s, w0, dw, type = 'pasabanda-pasabajos')
  % Se convierte en frecuencia
  % Para pasabanda-pasabajos: spb = (s^2 + w0^2) / (s * dw) -> DESNORMALIZADO EN FRECUENCIA

  if (strcmp(type, 'pasabanda-pasabajos'))
    spb = (s^2 + w0^2) / (s*dw);
    return;
  else 
    dispc('ERROR: no implementado', 'red');
    return;
  end

end
