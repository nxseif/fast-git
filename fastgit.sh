#!/bin/bash

fle="$1"

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1
then
    echo "warning youre not inside git repo!!"
    exit 1
fi

if [ -z "$fle" ]
then
    echo "usage: fastgit filename"
    exit 1
fi

if [ ! -f "$fle" ]
then
    echo "warning: file does not exist"
    exit 1
fi

if ! git add "$fle"
then
    echo "warning: git add fail"
    exit 1
fi

if ! git commit -m "Update $fle"
then
    echo "warning:commit fail"
    exit 1
fi

if ! git push
then
    echo "warining add failed"
    exit 1
fi

echo "done"
