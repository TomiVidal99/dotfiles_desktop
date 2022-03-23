function string = interval2string(int, txt = '')

  len = length(int);
  step = int(2)-int(1);
  hasPi = pidivisibles(step);

  %dispc(strcat("is divisible: ", num2str(hasPi), "\n"), "red");

  for (i = 1:len)
    if (hasPi == 1)
      number = int(i)/pi;
    else
      number = int(i);
    end
    string{i} = strcat(num2str(number), txt);
  end

end
