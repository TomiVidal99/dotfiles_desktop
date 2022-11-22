#!/bin/bash

# Gets the documents listed in the 'documents_dir'
# file and lets you (with rofi) open them in your file manager


DOCUMENTS_READER=okular
DIRECTORIES=~/.dotfiles/.utility/common/documents_dir

# sets the folder icon by applying an echo pattern
function apply_folder_pattern() {
  xargs -I '{}' echo -en "{}\0icon\x1ffolder\n"
}

function rofi_command() {
  apply_folder_pattern | rofi -dmenu -i -markup-rows -p "Seleccione un documento"
}

function parse_documents() {
  xargs -I '{}' basename -s .pdf {}
}

DOCUMENTS=$(cat $DIRECTORIES | xargs -I '{}' fd -e pdf . {})
SELECTED_DOCUMENT_NAME=$(echo "$DOCUMENTS" | parse_documents | rofi_command)
SELECTED_DOCUMENT_PATH=$(echo "$DOCUMENTS" | grep "$SELECTED_DOCUMENT_NAME")

if [[ "$SELECTED_DOCUMENT_NAME" = "" || "$SELECTED_DOCUMENT_PATH" = "" ]]; then
  #rofi -e "You didn't select a document!\n"
  exit
fi

echo "Path: $SELECTED_DOCUMENT_PATH"

$DOCUMENTS_READER "${SELECTED_DOCUMENT_PATH}" & disown
