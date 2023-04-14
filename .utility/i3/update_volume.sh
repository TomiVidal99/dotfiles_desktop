#!/bin/bash

# TODO: check when the volume it's ZERO or its MUTED.

# Handles volume update and sends a notification

# Updates volume and updates the i3 status bar
if [[ "$1" == "UP" ]]; then
  pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
elif [[ "$1" == "DOWN" ]]; then
  pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
fi

# Displays the volume in a notification
CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Eo "[0-9][0-9]%" | sed "s/\\n//g") # returns the volume percentage of each side
LEFT_VOLUME=$(echo $CURRENT_VOLUME | awk '{print $1;}')
RIGHT_VOLUME=$(echo $CURRENT_VOLUME | awk '{print $2;}')
MSG_TITLE="Volumen"

if [[ "$LEFT_VOLUME" == "$RIGHT_VOLUME" ]]; then
  MSG_BODY="🔊 $LEFT_VOLUME"
else
  MSG_BODY="🔊 $LEFT_VOLUME/$RIGHT_VOLUME"
fi

notify-send -t 750 "$MSG_TITLE" "$MSG_BODY"
