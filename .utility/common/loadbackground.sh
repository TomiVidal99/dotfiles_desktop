#!/bin/zsh

DEFAULT_BACKGROUND=japanese-resto
kill $(pidof -x loop_pngs.sh)
./loop_pngs.sh $DEFAULT_BACKGROUND & disown
