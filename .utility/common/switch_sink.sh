#!/bin/bash

DMENU=${DMENU:-dmenu}
INITIAL_MSG="Set default sink: "

# name of the devices that you want to switch sinks
SPEAKERS_NAME="alsa_output.pci-0000_00_1b.0.analog-stereo"
HEADSET_NAME="alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"
# from the names i get the sink number
SPEAKERS_SINK="$(pactl list short sinks | grep ${SPEAKERS_NAME} | awk '{print $1}')"
HEADSET_SINK="$(pactl list short sinks | grep ${HEADSET_NAME} | awk '{print $1}')"
# current sink number that is running
RUNNING_SINK="$(pactl list sinks | grep RUNNING -B 1 | head -n 1 | awk '{print }' | cut -d " " -f 2 | tr -dc '[:alnum:]')"

if [ $HEADSET_SINK > 0 ]; then
    # case when the headset is plugged
    if [ $SPEAKERS_SINK != $RUNNING_SINK ]; then
        pactl set-default-sink $SPEAKERS_SINK
        notify-send --hint=int:transient:1 -t 1000 --urgency=critical "PARLANTES ACTIVOS" "${SPEAKERS_NAME}"
        pactl list short sink-inputs|while read stream; do
            streamId=$(echo $stream|cut '-d ' -f1)
            pactl move-sink-input "$streamId" "$SPEAKERS_SINK"
        done
    else
        pactl set-default-sink $HEADSET_SINK
        notify-send --hint=int:transient:1 -t 1000 --urgency=critical "AURICULARES ACTIVOS" "${HEADSET_NAME}"
        pactl list short sink-inputs|while read stream; do
            streamId=$(echo $stream|cut '-d ' -f1)
            pactl move-sink-input "$streamId" "$HEADSET_SINK"
        done
    fi 
else
    # case when the headset is NOT plugged
    notify-send --hint=int:transient:1 -t 2000 --urgency=critical "Error" "Auriculares no conectados" 
fi

