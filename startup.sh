#!/bin/bash

EMACS_DIR="/emacsDocuments";

if [ ! -d "$EMACS_DIR" ];
then
    echo "No volume bound to $EMACS_DIR. Please start the container with \"-v <desired path to directory on the host>:$EMACS_DIR\"";
    exit 1
fi

echo "List of given parameters, will be used as files which will be opened by emacs from directory $EMACS_DIR: $@"

declare -a files=("$EMACS_DIR/");

for file in $@
do
    files=("$files" "$EMACS_DIR/$file");
done

echo $files[0] $files[1]
echo "${files[@]}"
echo "${files[@]/#/ }"


exec emacs "${files[@]}"
#exec emacs "${files[@]/#/ }"
