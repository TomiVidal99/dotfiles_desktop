#!/bin/bash

DMENU=${DMENU:-dmenu}
INITIAL_MSG="Set new sink: "

NEW_SINK="$( echo | ${DMENU} -fn "Inconsolata Condensed SemiBold 20" -nb "#e2845f" -sb "#000000" -p "$INITIAL_MSG" )"

pactl set-default-sink $NEW_SINK
RUNNING_SINK = "$(pactl short sinks | grep RUNNING | grep Name | awk '{print $2}')"

pactl list short sink-inputs|while read stream; do
    streamId=$(echo $stream|cut '-d ' -f1)
    echo "moving stream $streamId"
    pactl move-sink-input "$streamId" "$NEW_SINK"
done

if [ $? == 0 ]; then
    notify-send --hint=int:transient:1 -t 600 --urgency=critical "$RUNNING_SINK" "Default sink cambiada"
else
    notify-send --hint=int:transient:1 -t 600 --urgency=critical "ERROR" "No hay ninguna sink con ese numero"
fi

