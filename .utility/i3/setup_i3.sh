#!/bin/bash

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
  files=$(ls $MODULES_DIRECTORY | grep $1 | xargs -I % echo $MODULES_DIRECTORY/%)
  for f in $files; do
    filename="${f##*/}"
    file_content=$(cat $f)
    title_divier="# - - - - - - - - - - $(echo $filename | cut -d'.' -f1) ($1) - - - - - - - - - - "
    title_end="# - - - - - - - - - - - - - - - - - - - - "
    printf '%s\n%s\n%s\n\n' "$title_divier" "$file_content" "$title_end" >> $CONFIG_FILE
  done
}

create_config_file "global"
IS_DESKTOP=$(uname -a | grep desktop)
if ! [ -z IS_DESKTOP ]; then
  # DESKTOP
  create_config_file "desktop"
else
  # LAPTOP
  create_config_file "laptop"
fi
