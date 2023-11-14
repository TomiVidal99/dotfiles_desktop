#!/bin/bash

# TODO: change the current system to execute scripts 
# in a certain order to name them with a number that 
# specifies that order, ie: 1.variables.3ZQglobal

# This will generate the i3/config file
# The gold it's to modulerize the config and 
# provide different configs dependent of the system (desktop and laptop).

# General syntax of the modules:
#   - for all systems *.global
#   - for desktop *.desktop
#   - for laptop *.laptop

CONFIG_FILE=~/.config/i3/config
MODULES_DIRECTORY=~/.dotfiles/.utility/i3/config_modules

rm -f "$CONFIG_FILE"

function create_config_file() {
  files=$(ls $MODULES_DIRECTORY | grep $1 | grep -v $2 | xargs -I % echo $MODULES_DIRECTORY/%)
  for f in $files; do
    filename="${f##*/}"
    printf ' -> %s \n' "$filename"
    file_content=$(cat $f)
    title_divier="# - - - - - - - - - - $(echo $filename | cut -d'.' -f1) ($1) - - - - - - - - - - "
    title_end="# - - - - - - - - - - - - - - - - - - - - "
    printf '%s\n%s\n%s\n\n' "$title_divier" "$file_content" "$title_end" >> $CONFIG_FILE
  done
}

echo "*Order of modules:"

# execute these modules first
create_config_file "variables.global" "0"
create_config_file "windows.global" "0"
create_config_file "global" "variables.global\|windows.global"

IS_DESKTOP=$(uname -a | grep "desktop")
if ! [ -z "$IS_DESKTOP" ]; then
  # DESKTOP
  create_config_file "desktop" "0"
  MACHINE="DESKTOP"
else
  # LAPTOP
  create_config_file "laptop" "0"
  MACHINE="LAPTOP"
fi

echo "System detected: $MACHINE"
