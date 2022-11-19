#!/bin/bash

# Gets the documents listed in the 'documents_dir'
# file and lets you (with rofi) open them in your file manager


LS_COMMAND=/usr/bin/ls
DOCUMENTS_READER=okular
DIRECTORIES=~/.dotfiles/.utility/common/documents_dir

# sets the folder icon by applying an echo pattern
function apply_folder_pattern() {
  xargs -I '{}' echo -en "{}\0icon\x1ffolder\n"
}

function rofi_command() {
  apply_folder_pattern | rofi -dmenu -i -markup-rows -p "Seleccione un documento"
}

function get_documents() {
  xargs -I '{}' find {} -type f -name "*.pdf"
}

function parse_documents() {
  xargs -I '{}' basename -s .pdf {}
}

DOCUMENTS_PATHS=$(cat $DIRECTORIES | get_documents)
SELECTED_DOCUMENT=$(cat $DIRECTORIES | get_documents | parse_documents | rofi_command)
SELECTED_DOCUMENT_PATH=$(cat $DIRECTORIES | get_documents | grep "$SELECTED_DOCUMENT")

echo $SELECTED_DOCUMENT_PATH

if [[ "$SELECTED_DOCUMENT_PATH" = "" || "$SELECTED_DOCUMENT" = "" ]]; then
  #rofi -e "You didn't select a document!\n"
  exit
fi

$DOCUMENTS_READER "$SELECTED_DOCUMENT_PATH" & disown
