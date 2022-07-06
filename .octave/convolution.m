function result = convolution(f, g, opts)
%{
  Convolución entre las funciones f y g: {f * g}(t).
  Ejemplo de uso: convolucion = convolution(f, g);

  Argumentos:
    (f, @function) - Primera función
    (g, @function) - Segunda función
    (opts, @any) - Argumentos adicionales: mostarar animación de como se hace el calculo.

%}

  % validate length of arguments
  if (nargin != 2 && nargin != 3)
    print_usage();
  end

  % validate type of arguments
  typeinfof = typeinfo(f);
  typeinfog = typeinfo(g);
  if (strcmp(typeinfof, 'function handle') != 1 || strcmp(typeinfog, 'function handle') != 1))
   print_usage();
  end

end
