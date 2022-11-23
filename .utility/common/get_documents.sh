#!/bin/bash

# Gets the documents listed in the 'documents_dir'
# file and lets you (with rofi) open them in your file manager


DIRECTORIES=~/.dotfiles/.utility/common/documents_dir

# opens rofi with the right flags
function rofi_command() {
  rofi -dmenu -i -markup -markup-rows -p "Seleccione un documento"
}

# returns the line parsed with the data
function get_options_line() {
  name=$(basename -s pdf "$1")
  printf "<big><b>%s</b></big> - <small><i>%s</i></small>\x00icon\x1fapplication-pdf\n" "$name" "$1"
}

export -f get_options_line

# feeds all the one line options to the line creator
function parse_options() {
  xargs -I '{}' bash -c 'get_options_line "{}"'
}

# extracts the path from the given return value
function parse_selected_item() {
  sed -e 's/<i>\(.*\)<\\i>/\1/' 
}

DOCUMENTS=$(cat $DIRECTORIES | xargs -I '{}' fd -e pdf . {})
SELECTED_DOCUMENT_NAME=$(echo "$DOCUMENTS" | parse_options | rofi_command)
SELECTED_DOCUMENT_PATH=$(expr "$SELECTED_DOCUMENT_NAME" | sed -E "s/.*<i>//" | sed -E "s/<\/i>.*//")

echo "$SELECTED_DOCUMENT_NAME"
echo "$SELECTED_DOCUMENT_PATH"

if [[ "$SELECTED_DOCUMENT_NAME" = "" || "$SELECTED_DOCUMENT_PATH" = "" ]]; then
  exit
fi

xdg-open "$SELECTED_DOCUMENT_PATH"
