function isValid = between(n, a, b, equals = 1)
%{
  Function that will return weather a value (n) it's contain wihin an interval (1) [a,b] or not (0). 
  Usage Example: y = @(t) 1.*between(t, 0, 1);
  Output Example: 
                  $> between(0, 0, 1)
                  $> 1
  Arguments: 
            - (n, @number)
            - (a, @number)
            - (b, @number)
            - (equals, {0, 1, 2, 3})

            - "equals": Interval ends.
                0 -> (a, b)
                1 (DEFAULT VALUE) -> [a, b]
                2 -> [a, b)
                3 -> (a, b]
%}

  isValid = NaN;

  % handle case when the interval limits are equal
  if (b == a)
    help between;
    return
  end

  % reverse the interval if it's given backwards
  if (b < a)
    c = b;
    b = a;
    a = c;
  end

  % handle case for each type of interval end
  switch (equals)
    case 0
      isValid = (n>a).*(n<b);
    case 1
      isValid = (n>=a).*(n<=b);
    case 2
      isValid = (n>=a).*(n<b);
    case 3
      isValid = (n>a).*(n<=b);
    otherwise
      help between;
      exit;
  end


end
