function dispc(varargin)
  % function to print strings with a color.
  % Usage example: dispc(text, color);

  % ----- COLORS -----
  Default='[39m';  %	Default	Colors in the bash
  Black='[30m';  %	Black
  Red='[31m';  %	Red
  Green='[32m';  %	Green
  Yellow='[33m'; %	Yellow
  Blue='[34m'; %	Blue
  Magenta='[35m';  %	Magenta
  Cyan='[36m'; %	Cyan
  LightGray='[37m';  %	Light Gray
  DarkGray='[90m'; %	Dark Gray
  LightRed='[91m'; %	Light Red
  LightGreen='[92m'; %	Light Green
  LightYellow='[93m';  %	Light Yellow
  LightBlue='[94m';  %	Light Blue
  LightMagenta='[95m'; %	Light Magenta
  LightCyan='[96m';  %	Light Cyan
  White='[97m';  %	White
  % --------------------
  COLORS = struct(
    "default", Default,
    "black", Black,
    "red", Red,
    "green", Green,
    "yellow", Yellow,
    "blue", Blue,
    "magenta", Magenta,
    "cyan", Cyan,
    "light gray", LightGray,
    "dark gray", DarkGray,
    "light red", LightRed,
    "light green", LightGreen,
    "light yellow", LightYellow,
    "light blue", LightBlue,
    "light magenta", LightMagenta,
    "light cyan", LightCyan,
    "white", White
  );
  % --------------------

  p = inputParser();
  p.FunctionName = "dispc";
  p.addRequired("string", @char);
  p.addRequired("color", @char);
  p.parse(varargin{:});

  % extract arguments
  string = p.Results.string;
  color = p.Results.color;

  % validate the color
  availableColors = fieldnames(COLORS);
  colorIsValid = validatestring(color, availableColors);
  if (length(colorIsValid) == 0)
    clc;
    fprintf("ERROR: %s is not a valid color. Try one of the following: \n", color);
    strcat(availableColors, ', ');
  end

  coloredString = strcat(COLORS.(color), string);

  printf([char(27), coloredString, char(27), '[0m']);

end
