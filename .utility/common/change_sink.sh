#!/bin/bash

# Function to list available sinks in Rofi and return the selected sink index
function select_sink() {
  # Use pacmd to list sinks and their device.product.name
  sink_info=$(pacmd list-sinks | awk '/index:/ {sinks[++i] = $0} /device\.product\.name/ {names[++k] = $0} {str[++w] sinks[i] ", " names[k]} END {for (j = 1; j <= i; j++) print sinks[j] names[j]}' | sed 's/\*/(selected)/')

  # Extract the sink index and device.product.name for the Rofi menu
  menu_text=""
  while read -r sink_index device_product_name; do
    menu_text="$menu_text$sink_index $device_product_name\n"
  done <<< "$sink_info"
  selected_sink_index=$(echo -e "$menu_text" | grep -v '^$' | rofi -dmenu -i -markup-rows -mesg "Select an audio sink" -p "Audio Sink" | awk -F': ' '/index:/ {sub(/[^0-9].*/, "", $2); print $2}')
  echo "$selected_sink_index"
}

# Let the user select the new audio sink
NEW_SINK_INDEX=$(select_sink)

# Check if the user selected a sink
if [ -z "$NEW_SINK_INDEX" ]; then
    notify-send --hint=int:transient:1 -t 600 --urgency=critical "Error" "No sink selected"
    exit 1
fi

# Set the selected sink as the default sink
pacmd set-default-sink "$NEW_SINK_INDEX"

# Get a list of all running audio sources
sources=$(pacmd list-sink-inputs | grep 'index:' | awk '{print $2}')

# Move the audio sources to the new active sink
for source in $sources; do
  pacmd move-sink-input "$source" "$NEW_SINK_INDEX"
done

# Notify the user of the change
if [ $? == 0 ]; then
    notify-send --hint=int:transient:1 -t 1000 --urgency=low "Default sink changed"
else
    notify-send --hint=int:transient:1 -t 1000 --urgency=low "Error" "Failed to change default sink"
fi

