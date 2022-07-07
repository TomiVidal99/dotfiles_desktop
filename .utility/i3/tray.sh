#!/bin/bash

pkill -f pasystray
pkill -f blueman-tray
pkill -f nm-applet
pkill -f redshift-gtk

pasystray --notify=all &
blueman-tray &
nm-applet --indicator &
redshift-gtk &
disown
