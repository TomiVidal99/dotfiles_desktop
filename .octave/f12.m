function [f1,f2] = f12(df, f0, type = 'pasabanda-pasabajos')
  % Se retornan las frecuencias f1 y f2
  % según la ecuación f12 = +- df/2 + sqrt ( (df/2)^2 + f0^2 )  -> Para pasabanda-pasabajos
  % según la ecuación f12 = df/2 +- sqrt ( (df/2)^2 + f0^2 )  -> Para rechazabanda-pasabajos

  hdf = df/2;
  temp_srqt = sqrt( hdf^2 + f0^2 );

  if (strcmp(type, 'pasabanda-pasabajos'))
    f1 =  hdf + temp_srqt;
    f2 = -hdf + temp_srqt;
  else
    f1 = - hdf + temp_srqt;
    f2 = hdf + temp_srqt;
  end
  
end
