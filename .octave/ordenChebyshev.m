function [order] = ordenChebyshev(ap, as, ws, wp)
    % Se retorna el orden de un filtro de Chebyshev
    % dadas las atenuaciones y las frecuencias angulares
    % function [order] = ordenChebyshev(ap, as, ws, wp)

    n = acosh(sqrt(10^(ap/10))/sqrt(10^(as/10)))/acosh(ws/wp);

end
