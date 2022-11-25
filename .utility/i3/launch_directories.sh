#!/bin/bash
# Launches a menu with some common directories
# Dependencies: rofi

DIRECTORIES_APP=xdg-open

# sets the folder icon by applying an echo pattern
function apply_folder_pattern() {
  xargs -I '{}' echo -en "{}\0icon\x1ffolder\n"
}

# returns the line parsed with the data
function get_options_line() {
  foldername=$(echo "$1" | cut -d'=' -f1)
  folderpath=$(echo "$1" | cut -d'=' -f2)
  printf "<big><b>%s</b></big> - <small><i>%s</i></small>\x00icon\x1ffolder\n" "$foldername" "$folderpath"
}
export -f get_options_line

# extracts the path from the given return value
function get_path_from_selected_option() {
  sed -E "s/.*<i>//" | sed -E "s/<\/i>.*//" 
}

# executes rofi with the correct parameters
function rofi_command() {
  rofi -dmenu -i -markup -markup-rows -p "Seleccione una carpeta"
}

# feeds all the one line options to the line creator
function parse_options() {
  xargs -I '{}' bash -c 'get_options_line "{}"'
}

DIRECTORIES=~/.utility/i3/files_directories
WORKING_DIRECTORIES=~/.config/zsh/working_directories
PATHS=$(cat $DIRECTORIES $WORKING_DIRECTORIES)
SELECTED_DIRECTORY_NAME=$(echo "$PATHS" | parse_options | rofi_command)
SELECTED_DIRECTORY=$(echo "$SELECTED_DIRECTORY_NAME" | get_path_from_selected_option)

echo "$SELECTED_DIRECTORY"

if [[ "$SELECTED_DIRECTORY_NAME" = "" || "$SELECTED_DIRECTORY" = "" ]]; then
  #rofi -e "You didn't select a directory!\nDir name: ${SELECTED_DIRECTORY_NAME}\nDir path:${SELECTED_DIRECTORY}"
  exit
fi

$DIRECTORIES_APP "$SELECTED_DIRECTORY" & disown
