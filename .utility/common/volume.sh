#!/bin/bash

DMENU=${DMENU:-dmenu}
INITIAL_MSG="Porcentaje de volumen: "
PERCENTAGE="%"
RUNNING_SINK="$(pactl list sinks | grep RUNNING -B 1 | head -n 1 | awk '{print }' | cut -d " " -f 2 | tr -dc '[:alnum:]')"

VOLUMEN_PERCENTAGE="$( echo | ${DMENU} -fn "Inconsolata condensed SemiBold 20" -nb "#000000" -sb "#000000" -p "$INITIAL_MSG" )"

# TODO: add check against letters or symbols
if [ $VOLUMEN_PERCENTAGE -gt 0 ] || [ $VOLUMEN_PERCENTAGE -eq 0 ]; then
    pactl set-sink-volume $((RUNNING_SINK)) "${VOLUMEN_PERCENTAGE}${PERCENTAGE}"
    echo $RUNNING_SINK $VOLUMEN_PERCENTAGE $PERCENTAGE
    notify-send --hint=int:transient:1 -t 600 --urgency=critical "${VOLUMEN_PERCENTAGE}${PERCENTAGE}" "Volumen actual"
fi 
