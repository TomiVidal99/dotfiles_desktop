#!/bin/bash

DMENU=${DMENU:-dmenu}
INITIAL_MSG="Set RGB color 1, 2 and 3 for (RED, GREEN and BLUE): "

# name of the devices that you want to switch sinks
RED=1
GREEN=2
BLUE=3

COLOR="$( echo | ${DMENU} -fn "Inconsolata condensed SemiBold 20" -nb "#000000" -sb "#000000" -p "$INITIAL_MSG" )"

if [ $COLOR -gt 1 ]; then
  # for red
  sudo ~/temp/msi-rgb/msi-rgb/msi-rgb/target/release/msi-rgb FFFFFF 000000 00000000
elif [ $COLOR -gt 2 ]; then
  # for green
  sudo ~/temp/msi-rgb/msi-rgb/msi-rgb/target/release/msi-rgb 00000000 FFFFFFFF 00000000
elif [ $COLOR -gt 3 ]; then
  # for blue
  sudo ~/temp/msi-rgb/msi-rgb/msi-rgb/target/release/msi-rgb 00000000 00000000 FFFFFFFF
fi
