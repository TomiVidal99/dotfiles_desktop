function isDivisible = pidivisibles(varargin)
  % Checks if the given number is divisible by pi.
  % 0 if FALSE 1 if TRUE.

  p = inputParser();
  p.FunctionName = "pidivisibles";
  p.addRequired("number", @double);
  p.parse(varargin{:});
  number = p.Results.number;

  max_divisors = 100;
  tolerance = 1e-5;

  isDivisible = 0;
  for n = 1:max_divisors
    divisor = pi/n;
    %dispc(strcat("is div: ", num2str(number), " / ", num2str(divisor), "\n"), "green");
    if (mod(number, divisor) < tolerance)
      isDivisible = 1;
      return;
    end
  end

end
