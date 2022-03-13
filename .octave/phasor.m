function [magnitude, phase] = phasor(complexNumber)

    # devuelvo un fasor a partir de un numero complejo
    # la fase esta en grados

    magnitude = NaN;
    phase = NaN;

    [phase, magnitude] = cart2pol(real(complexNumber), imag(complexNumber));

    phase = rad2deg(phase);

    disp(cstrcat(num2str(magnitude), " ∠ ", num2str(phase), "°"));

end
