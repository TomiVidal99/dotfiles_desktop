#!/bin/bash

pkill -f pasystray
pkill -f blueman-tray
pkill -f nm-applet

pasystray --notify=all &
blueman-tray &
nm-applet --indicator &
