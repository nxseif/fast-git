#!/bin/bash

FILE="$1"

if [ -z "$FILE" ]; then
    echo "Usage: ./fastgit.sh <filename>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "Error: file '$FILE' does not exist."
    exit 1
fi

git add "$FILE"
git commit -m "Update $FILE"
git push
