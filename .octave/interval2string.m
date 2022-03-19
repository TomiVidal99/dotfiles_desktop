function string = interval2string(int, txt = '', hasPi = 0)

  len = length(int);
  step = int(2)-int(1);

  for (i = 1:len)
    if (hasPi == 1)
      number = int(i)/pi;
    else
      number = int(i);
    end
    disp(num2str(number));
    string{i} = strcat(num2str(number), txt);
  end

end
