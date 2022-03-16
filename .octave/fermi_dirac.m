 function [FERMI_DIRAC] = fermi_dirac(n)
  # Fermi-Dirac distribución de probabilidad de que un estado cuántico esté ocupado [unidad de volumen por unidad de energía].
  # Requiere que se defina Kb (constante de Boltzmann).
  fermi_dirac = @(E, Ef, T) 1 / (1 + exp( (E-Ef) / (Kb*T) )); 
  FERMI_DIRAC = fermi_dirac(n);
end
