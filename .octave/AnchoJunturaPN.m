function w = AnchoJunturaPN(Na, Nd, ni = 1.5e10, Vt = 0.0259)
  % Funcion que calcula el ancho W en la juntura PN dependiendo de Na, Nd y el voltaje de la juntura a temperatura T = 300°K, dada por la ecuación: Vt = Kb*T/e.
  % Usage example: AnchoJunturaPN(10e15, 5e15);

  w = NaN;

  Es = 11.7 * (8.85e-14); % Permitividad eléctrica del silicio.
  E = 1.6022e-19; % Carga del electrón.

  % calculo el voltaje de la juntura.
  Vbi = Vt.*log((Na.*Nd)/(ni.**2));

  % calculo el ancho de la juntura.
  w = ( ((2*Es*Vbi)/(E)) .* ( (Na+Nd)/(Na*Nd) ) ).**(1/2);

end
