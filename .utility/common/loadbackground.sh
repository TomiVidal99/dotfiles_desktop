#!/bin/zsh

DEFAULT_BACKGROUND=japanese-resto
SCRIPTS_DIRECTORY=/home/tomii/Imágenes/backgrounds/animated-background/scripts
SCRIPTS_REPO=https://github.com/sdaveas/i3-animated-background

if [ -d $SCRIPTS_DIRECTORY ]; then
  kill $(pidof -x loop_pngs.sh)
  cd $SCRIPTS_DIRECTORY
  ./loop_pngs.sh $DEFAULT_BACKGROUND & disown
else
  echo "The scripts directory does not exist. Verify location or clone the repo: $SCRIPTS_REPO"
fi
