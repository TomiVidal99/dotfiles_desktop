function msg = dispv(varargin)
  % Displays arguments concatenated as text, IT WON'T JUMP LINE AFTER.
  % Usage example: dispv("var1: ", var1);

  msg = "";

  % helper function to handle error depending on package dependencies.
  function handleError(msg)
    if (exist("dispc"))
      dispc(msg, "red");
    else
      fprintf(msg);
    end
    help dispv;
  end

  % Check if the user has given any arguments.
  if (length(varargin) == 0)
    errorMsg = "ERROR: You have to give at least one argument.\n";
    handleError(errorMsg);
    return;
  end

  % concatenate arguments, check if it's a number and convert.
  for (i = 1:length(varargin))
    arg = varargin{i};
    if (ischar(arg))
      msg = cstrcat(msg, arg);
    elseif (isnumeric(arg))
      msg = cstrcat(msg, num2str(arg));
    else 
      errorMsg = "You have entered an argument that is NOT text and NOT numeric. \n";
      handleError(errorMsg);
      return;
    end
  end

end
