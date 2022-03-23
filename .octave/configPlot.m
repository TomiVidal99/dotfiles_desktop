function configPlot(varargin)
  % función configPlot
  % Es una función utilitaria para configurar los plots.
  %
  % Ejemplo de uso:
  % configPlot("xlabel", '\pi', "limits", [-10*pi, 10*pi, -2, 2]);
  %
  % Argumentos validos:
  %
  % ("figure", @doble)
  % ("title", @char)
  % ("limits", @any)
  % ("xstep", @double)
  % ("ystep", @double)
  % ("fontsize", @double)
  % ("linewidth", @double)
  % ("xlabel", @char)
  % ("ylabel", @char)

  % check if the user entered the correct amount of arguments and values.
  argumentsLength = length(varargin);
  if (mod(argumentsLength, 2) != 0)
    clc;
    dispc("ERROR: wrong amount of arguments\n", "red");
    dispc("function usage: configPlot(\"KEY\", VALUE)\n\n", "dark gray");
    return;
  end

  defaultSettings = struct(
    "figure", 1,
    "title", "Gráfico 1",
    "limits", "auto",
    "xstep", .2,
    "ystep", .2,
    "fontsize", 16,
    "fontsizeLegend", 20,
    "linewidth", 3,
    "xlabel", "",
    "ylabel", ""
  );
  allowAnyType = {"limits"};

  p = inputParser();
  p.FunctionName = "configPlot";

  % add optional arguments
  for [value, key] = defaultSettings
    filteredFlag = false;

    % allow parameters with any type
    for (n = 1:length(allowAnyType))
      if (strcmpi(key, allowAnyType(n)))
        p.addParameter(key, @any);
        %fprintf("key: %s, @any \n", key);
        filteredFlag = true;
        break;
      end
    end

    if (filteredFlag == false)
      if (ischar(value))
        p.addParameter(key, @char);
        %fprintf("key: %s, @char \n", key);
      else
        p.addParameter(key, @double);
        %fprintf("key: %s, @double \n", key);
      end
    end

  end

  p.parse(varargin{:});

  arguments = fieldnames(p.Results);

  % i check that the arguments entered whered valid
  availableKeys = fieldnames(defaultSettings);
  for (n = 1:(length(varargin)/2))
    argument = varargin{n*2-1};
    validatestring(argument, availableKeys);
    value = varargin{n*2};
    defaultSettings.(argument) = value;
  end

  % set default values
  Figure = defaultSettings.("figure");
  Title = defaultSettings.("title");
  limits = defaultSettings.("limits");
  xstep = defaultSettings.("xstep");
  ystep = defaultSettings.("ystep");
  fontsize = defaultSettings.("fontsize");
  fontsizeLegend = defaultSettings.("fontsizeLegend");
  linewidth = defaultSettings.("linewidth");
  labelX = defaultSettings.("xlabel");
  labelY = defaultSettings.("ylabel");

  figure(Figure); % select the graph
  title(Title); % set title
  grid on; % set grid
  hold on; % preserve changes
  set(gca, "linewidth", linewidth, "fontsize", fontsize); % set linewidth and fontsize
  %h = legend()
  %set(gca)

  axis(limits);
  xbounds = xlim();
  ybounds = ylim();
  set(gca, "xtick", xbounds(1):xstep:xbounds(2));
  set(gca, "ytick", ybounds(1):ystep:ybounds(2));

  if (ischar(labelX)) 
    intx = [xbounds(1):xstep:xbounds(2)];
    if (ischar(limits) != 1)
      intx = [limits(1):xstep:limits(2)];
      set(gca, "ytick", intx);
    end
    set(gca, "xticklabel", interval2string(intx, labelX));
  end

  if (isstring(labelY) || ischar(labelY)) 
    inty = [ybounds(1):ystep:ybounds(2)];
    if (ischar(limits) != 1)
      inty = [limits(3):ystep:limits(4)];
      set(gca, "ytick", inty);
    end
    set(gca, "yticklabel", interval2string(inty, labelY));
  end

end
