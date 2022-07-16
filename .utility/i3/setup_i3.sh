#!/bin/bash

# This will generate the i3/config file
# The gold it's to modulerize the config and 
# provide different configs dependent of the system (desktop and laptop).

IS_DESKTOP=$(uname -a | grep desktop)
if ! [ -z IS_DESKTOP ]; then
  # DESKTOP
  cat shortcuts "\n\n\n" >> ~/.config/i3/config
  cat shortcuts "\n\n\n" >> ~/.config/i3/config
else
  # LAPTOP
  cat shortcuts_laptop >> ~/.config/i3/config
fi
