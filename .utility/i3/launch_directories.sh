#!/bin/bash
# Launches a menu with some common directories
# Dependencies: rofi

# sets the folder icon by applying an echo pattern
function apply_folder_pattern() {
  xargs -I '{}' echo -en "{}\0icon\x1ffolder\n"
}

function rofi_command() {
  apply_folder_pattern | rofi -dmenu -i -markup-rows -p "Seleccione una carpeta"
}

DIRECTORIES=~/.utility/i3/files_directories
SELECTED_DIRECTORY_NAME=$(cat $DIRECTORIES | cut -d'=' -f1 | rofi_command )
SELECTED_DIRECTORY=$(cat $DIRECTORIES | grep $SELECTED_DIRECTORY_NAME | cut -d'=' -f2)
DIRECTORIES_APP=dolphin

if [[ "$SELECTED_DIRECTORY_NAME" = "" || "$SELECTED_DIRECTORY" = "" ]]; then
  #rofi -e "You didn't select a directory!\nDir name: ${SELECTED_DIRECTORY_NAME}\nDir path:${SELECTED_DIRECTORY}"
  exit
fi

$DIRECTORIES_APP $SELECTED_DIRECTORY & disown
