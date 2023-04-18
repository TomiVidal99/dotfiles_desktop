function [output] = mobile_average(signal, M)
  % Calculates the mobile average of a given signal
  % By default M it's 2N+1 (the length of the signal)
  % If you increase M the signal will be more filtered

  output = NaN;

  for j = 1:length(signal)
    output(j) = 0;
    for i = -M:M
      if (j-i > 1 && j-i <= length(signal))
        output(j) = output(j) + (1/M)*signal(j-i);
      end
    end
  end

end
