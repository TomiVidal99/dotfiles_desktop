function string = interval2string(int, txt = '')

  len = length(int);
  step = int(2)-int(1);

  disp('step ');
  disp(step);

  for (i = 1:len)
    number = int(i)/step;
    string{i} = strcat( int2str(number), txt);
  end

end
