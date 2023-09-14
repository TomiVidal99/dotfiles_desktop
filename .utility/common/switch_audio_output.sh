#!/bin/bash

# List available audio output devices and their indexes
echo "Available audio output devices:"
available_sinks=$(pacmd list-sinks | awk '/index: [0-9]+$/ {print $2, $3}')
index=0
for sink in $available_sinks; do
    echo "[$index] ${sink#*.*}"
    index=$((index+1))
done

# Get the current default sink
current_sink=$(pacmd info | awk '/Default sink name:/ {print $4}')

# Find the index of the current sink in the list of available sinks
current_index=$(echo "$available_sinks" | grep -n "^$current_sink " | cut -d ':' -f 1)

# Calculate the index of the next sink to switch to
next_index=$(( (current_index % $(echo "$available_sinks" | wc -l)) + 1 ))

# Get the name of the next sink
next_sink=$(echo "$available_sinks" | sed -n "${next_index}p" | awk '{print $2}')

# Set the next sink as the default output
pactl set-default-sink "$next_sink"

# Move existing inputs to the new sink
for input_index in $(pacmd list-sink-inputs | awk '/index: [0-9]+$/ {print $2}'); do
    pacmd move-sink-input "$input_index" "$next_sink"
done

echo "Audio output switched to: $next_sink"

