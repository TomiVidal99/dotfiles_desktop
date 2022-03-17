function int = interval(limits = NaN, step = 1)
  % create an interval simple by passing only the limit
  % you can specify step as well, by default it's 1

  if (limits == NaN)
    exit
  end

  int = [-limits:step:limits];

end
